require 'json-schema'
require 'active_support'
require 'active_support/core_ext/object/to_json'
require 'active_model/serializer'
require 'active_model/serializer/validator/mixin'
require 'composition/version'

module Composition
end

# Inject the mixin in the ActiveModel::Serializer class
ActiveModel::Serializer.send :include, ActiveModel::Serializer::Validator::Mixin
