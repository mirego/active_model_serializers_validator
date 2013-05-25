$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "rspec"
require 'ostruct'
require "active_model_serializers_validator"

# Require everything in `spec/support`
Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].map(&method(:require))

# Configure RSpec
RSpec.configure do |config|
  # Modules
  config.include Fixtures
  config.include Serializers

  # Hooks
  config.before(:suite) do
    class OpenStruct
      def read_attribute_for_serialization(attribute)
        self.send(attribute)
      end
    end
  end
end
