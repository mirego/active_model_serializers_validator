require 'json-schema'
require 'active_model/serializer/validator'

# Inject the mixin in the ActiveModel::Serializer class
ActiveModel::Serializer.send :include, ActiveModel::Serializer::Validator::Mixin
