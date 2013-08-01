module ActiveModel
  class Serializer
    module Validator
      module Mixin
        extend ActiveSupport::Concern

        included do
          attr_reader :errors
        end

        # Return whether the serializer output is valid
        def valid?
          @errors = self.class.valid_against_schema?(self.class.json_schema, self)
          @errors.empty?
        end

        module ClassMethods
          # Set the JSON schema to use for this class
          def json_schema(value = nil)
            @_json_schema ||= begin
              superclass.json_schema if superclass.respond_to?(:json_schema)
            end

            return @_json_schema unless value

            if !value.is_a?(String) && !value.is_a?(Hash)
              raise InvalidSchemaError.new('Schema must be a path to a file or a Hash.')
            elsif value.is_a?(String) && !File.exists?(value)
              raise InvalidSchemaError.new('Schema file does not exist.')
            else
              @_json_schema = value
            end
          end

          # Validate the rendered data against a JSON schema file and
          # return an errors array
          def valid_against_schema?(schema, serializer)
            JSON::Validator.fully_validate(schema, serializer.to_json)
          end
        end
      end
    end
  end
end
