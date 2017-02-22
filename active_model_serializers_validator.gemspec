# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model/serializer/validator/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_model_serializers_validator'
  spec.version       = ActiveModel::Serializer::Validator::VERSION
  spec.authors       = ['Rémi Prévost']
  spec.email         = ['rprevost@mirego.com']
  spec.description   = 'An extension to ActiveModel::Serializer that validates serializers output against a JSON schema'
  spec.summary       = 'An extension to ActiveModel::Serializer that validates serializers output against a JSON schema'
  spec.homepage      = 'https://github.com/mirego/active_model_serializers_validator'
  spec.license       = 'BSD 3-Clause'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14', '>= 1.14.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec',   '~> 3.5'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'json',    '~> 2.0', '>= 2.0.3'

  spec.add_dependency 'activesupport',            '~> 4.2', '>= 4.2.8'
  spec.add_dependency 'active_model_serializers', '~> 0.10.4'
  spec.add_dependency 'json-schema',              '~> 2.8'
end
