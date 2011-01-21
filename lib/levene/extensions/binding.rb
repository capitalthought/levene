module Levene
  module Extensions
    module Binding

      def logout
        response = call_remote(:logout, [])
        @session_id = nil
      end

      def describe(model)
        result = call_remote(:describeSObject, :sObjectType => model.name.demodulize)
        if result[:Fault]
          raise result[:Fault][:faultstring]
        else
          return result[:describeSObjectResponse][:result][:fields]
        end
      end

      def query(model, conditions)
        full_query = "SELECT #{model.columns.collect {|c| c[:name]}.join(", ")} FROM #{model.model_name.demodulize} #{conditions || ""}"
        result = call_remote(:query, :queryString => full_query)
        if result[:Fault]
          raise result[:Fault][:faultstring]
        else
          result[:queryResponse][:result].nil? ? [] : [result[:queryResponse][:result][:records]].flatten
        end
      end

      def create(model)
        return false unless model.valid?
        result = call_remote(:create, model.to_s_object)
        if result[:Fault]
          raise result[:Fault][:faultstring]
        else
          unless result[:createResponse][:result][:id].nil?
            model.id = result[:createResponse][:result][:id]
            return true
          else
            model.errors.add_to_base(result[:createResponse][:result][:errors][:message])
            return false
          end
        end
      end
    end
  end
end
