# ActiveModel::Serializer::Validator

[![Gem Version](https://badge.fury.io/rb/active_model_serializers_validator.png)](https://rubygems.org/gems/active_model_serializers_validator)
[![Build Status](https://travis-ci.org/mirego/active_model_serializers_validator.png?branch=master)](https://travis-ci.org/mirego/active_model_serializers_validator)

This gem adds JSON schema validations for the JSON output generated by an `ActiveModel::Serializer`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_serializers_validator'
```

## Usage

The gem adds two instance methods (`#valid?` and `#errors`) and one class method (`.json_schema`) to the `ActiveModel::Serializer` class.

### A JSON schema

```json
{
  "type": "object",
  "$schema": "http://json-schema.org/draft-03/schema",
  "id": "#",
  "required": false,
  "additionalProperties": false,
  "properties": {
    "favorite_number": {
      "type": "integer",
      "id": "favorite_number",
      "required": true
    },
  }
}
```

### A serializer

```ruby
class MySerializer < ActiveModel::Serializer
  json_schema '/path/to/my/schema.jsonschema'
  attribute :favorite_number
end

object = OpenStruct.new(favorite_number: 'what?')
serializer = MySerializer.new(object)

serializer.valid?
# => false

serializer.errors
# => [The property '#/foo' of type String did not match the following type: integer in schema /path/to/my/schema.jsonschema]
```

## License

`ActiveModel::Serializer::Validator` is © 2013 [Mirego](http://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).  See the [`LICENSE.md`](https://github.com/mirego/active_model_serializers_validator/blob/master/LICENSE.md) file.

## About Mirego

Mirego is a team of passionate people who believe that work is a place where you can innovate and have fun. We proudly build mobile applications for [iPhone](http://mirego.com/en/iphone-app-development/ "iPhone application development"), [iPad](http://mirego.com/en/ipad-app-development/ "iPad application development"), [Android](http://mirego.com/en/android-app-development/ "Android application development"), [Blackberry](http://mirego.com/en/blackberry-app-development/ "Blackberry application development"), [Windows Phone](http://mirego.com/en/windows-phone-app-development/ "Windows Phone application development") and [Windows 8](http://mirego.com/en/windows-8-app-development/ "Windows 8 application development") in beautiful Quebec City.

We also love [open-source software](http://open.mirego.com/) and we try to extract as much code as possible from our projects to give back to the community.
