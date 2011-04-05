module Levene
  module Extensions
    module Binding
      DELETE_ID_LIMIT = 200
      def logout
        response = call_remote(:logout, [])
        @session_id = nil
      end

      def call_api(*args)
        result = call_remote(*args)
        if result[:Fault]
          raise result[:Fault][:faultstring]
        else
          return result
        end
      end

      def describe(model)
        result = call_api(:describeSObject, :sObjectType => model.name.demodulize)
        return result[:describeSObjectResponse][:result][:fields]
      end

      def query(model, conditions)
        full_query = "SELECT #{model.columns.collect {|c| c[:name]}.join(", ")} FROM #{model.model_name.demodulize} #{conditions || ""}"
        result = call_api(:query, :queryString => full_query)
        result[:queryResponse][:result].nil? ? [] : [result[:queryResponse][:result][:records]].flatten
      end

      def create(model)
        return false unless model.valid?
        result = call_api(:create, model.to_s_object(:creatable))
        unless result[:createResponse][:result][:id].nil?
          model.id = result[:createResponse][:result][:id]
          return true
        else
          model.errors.add_to_base(result[:createResponse][:result][:errors][:message])
          return false
        end
      end

      def update(model)
        return false unless model.valid?
        result = call_api(:update, model.to_s_object(:updateable))
        if result[:updateResponse][:result][:success] == "false"
          model.errors.add_to_base(result[:updateResponse][:result][:errors][:message])
          return false
        else
          return true
        end
      end
            
      def delete(models)
        ids = models.collect { |m| [:ids, m.id] }.flatten
        ids.each_slice(DELETE_ID_LIMIT) do |group|
          result = call_api(:delete, group)
        end
      end
      
    end
  end
end
