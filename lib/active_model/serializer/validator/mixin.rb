module ActiveModel
  class Serializer
    module Validator
      module Mixin
        extend ActiveSupport::Concern

        # Validate the rendered data against a JSON schema file
        def valid_against_schema?(schema)
          JSON::Validator.validate(schema, self.to_json)
        end

        # Return whether the serializer output is valid
        def valid?
          valid_against_schema?(self.class.json_schema)
        end

        module ClassMethods
          # Set the JSON schema to use for this class
          def json_schema(value = nil)
            @_json_schema ||= begin
              superclass.json_schema if superclass.respond_to?(:json_schema)
            end

            return @_json_schema unless value
            @_json_schema = value
          end
        end
      end
    end
  end
end
