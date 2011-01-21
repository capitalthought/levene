require 'active_model'
require 'active_support/core_ext/class/attribute'

module Salesforce
  module Models
    class Base
      extend ActiveModel::Naming
      include ActiveModel::Validations

      class_attribute :connection

      def attributes
        self.class.attr_names.inject({}) do |memo, name|
          memo[name] = self.send(name)
          memo
        end
      end

      def attributes=(attrs)
        attrs.each do |attr, val|
          if attr[0] == attr[0].upcase
            attr = attr.to_s.underscore
            attr = attr[0].downcase + attr[1..-1]
          end

          if attr == "id" && Array === val
            val = val.first
          end

          self.send "#{attr}=", val if self.respond_to?("#{attr}=".to_sym)
        end
      end

      def save
        if self.id.nil?
          self.connection.binding.create(self) 
        else
          self.connection.binding.update(self)
        end
      end

      def to_s_object
        attributeMap = self.attributes.inject({}) do |memo, attr|
          next memo if attr.last.nil? || attr.last.blank?
          salesforce_attr_name = attr.first.to_s.camelize
          if attr.first.to_s.ends_with?("__c")
            salesforce_attr_name.gsub!(/_c$/, "__c")
          end
          memo[salesforce_attr_name] = attr.last
          memo
        end

        fieldsToNull = self.attributes.select {|k,v| self.class.column_hash[k][:createable] == "true" && (v.nil? || v.blank?)}.collect {|k,v| k.to_s.camelize}
        fieldsToNull = fieldsToNull.collect {|k| k[0].downcase + k[1..-1]}
        
        {:sObject => {"xsi:type" => self.class.model_name.demodulize}.merge(attributeMap)}
      end

      class << self
        attr_accessor :abstract
        alias_method :abstract?, :abstract
        attr_accessor :columns
        attr_accessor :attr_names
        attr_accessor :column_hash

        def abstract!
          self.abstract = true
        end

        def inherited(klazz)
          klazz.abstract = false
          klazz.get_column_definitions
        end

        def find(*ids)
          results = self.connection.find(self,ids)
        end

        def find_by_soql(query)
          result = self.connection.binding.query(self, query)
          return [] if result == [nil]
          result.collect {|r| obj = self.new; obj.attributes = r; obj}
        end

        def get_column_definitions
          self.columns = self.connection.binding.describe(self)
          self.columns.each do |col|
            next if col[:deprecatedAndHidden] == "true"

            attribute = (col[:name][0].downcase + col[:name][1..-1]).underscore
            self.attr_names ||= []
            self.attr_names << attribute.to_sym
            self.column_hash ||= {}
            self.column_hash[attribute.to_sym] = col

            attr_accessor attribute

            if col[:nillable] == "false" && col[:createable] == "true" && col[:defaultedOnCreate] != "true"
              validates_presence_of attribute
            end

            if col[:type] == "string" && col[:length] && col[:length].to_i > 0
              validates_length_of attribute, :maximum => col[:length].to_i
            end

            if col[:picklistValues]
              valid_values = col[:picklistValues].select {|h| h[:active] == "true"}.collect {|h| h[:value]}
              default = col[:picklistValues].find {|h| h[:defaultValue] == "true"}
              if col[:nillable] == "true" || col[:createable] == "false"
                validates_inclusion_of attribute, :in => valid_values, :allow_nil => true
              else
                validates_inclusion_of attribute, :in => valid_values
              end

              if default
                class_eval """def #{attribute}
                    @#{attribute} ||= \"#{default[:value]}\"
                   end"""
              end
            end
          end
        end

        def connection_established?
          !connection.nil? && connection.has_session?
        end

        def establish_connection
          self.connection = Salesforce::Connection.new
          self.connection.login ENV["SALESFORCE_DEV_USER"], ENV["SALESFORCE_DEV_PASS"]
        end

      end

      abstract!
      establish_connection
      
    end
  end
end
