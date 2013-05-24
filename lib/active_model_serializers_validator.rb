require 'json-schema'
require 'active_model/serializer/validator/mixin'
require 'active_model/serializer/validator/version'

# Inject the mixin in the ActiveModel::Serializer class
ActiveModel::Serializer.send :include, ActiveModel::Serializer::Validator::Mixin
