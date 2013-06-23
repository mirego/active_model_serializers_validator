# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'composition/version'

Gem::Specification.new do |spec|
  spec.name          = 'composition'
  spec.version       = Composition::VERSION
  spec.authors       = ['Rémi Prévost']
  spec.email         = ['rprevost@mirego.com']
  spec.description   = 'An extension to ActiveModel::Serializer that validates serializers output against a JSON schema'
  spec.summary       = 'An extension to ActiveModel::Serializer that validates serializers output against a JSON schema'
  spec.homepage      = 'https://github.com/mirego/composition'
  spec.license       = 'BSD 3-Clause'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.13'
  spec.add_development_dependency 'json', '~> 1.7.7'

  spec.add_dependency "activesupport", '>= 3.0.0'
  spec.add_dependency "active_model_serializers", '~> 0.8'
  spec.add_dependency "json-schema", '~> 1.1'
end
