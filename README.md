# Validations

[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![Build status](https://img.shields.io/travis/vladfaust/validations.cr/master.svg?style=flat-square)](https://travis-ci.org/vladfaust/validations.cr)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg?style=flat-square)](https://github.vladfaust.com/validations.cr)
[![Releases](https://img.shields.io/github/release/vladfaust/validations.cr.svg?style=flat-square)](https://github.com/vladfaust/validations.cr/releases)
[![Awesome](https://github.com/vladfaust/awesome/blob/badge-flat-alternative/media/badge-flat-alternative.svg)](https://github.com/veelenga/awesome-crystal)
[![vladfaust.com](https://img.shields.io/badge/style-.com-lightgrey.svg?longCache=true&style=flat-square&label=vladfaust&colorB=0a83d8)](https://vladfaust.com)
[![Patrons count](https://img.shields.io/badge/dynamic/json.svg?label=patrons&url=https://www.patreon.com/api/user/11296360&query=$.included[0].attributes.patron_count&style=flat-square&colorB=red&maxAge=86400)](https://www.patreon.com/vladfaust)

A validations module for [Crystal](https://crystal-lang.org/).

[![Become a Patron](https://vladfaust.com/img/patreon-small.svg)](https://www.patreon.com/vladfaust)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  validations:
    github: vladfaust/validations.cr
    version: ~> 0.1.4
```

This shard follows [Semantic Versioning 2.0.0](https://semver.org/), so see [releases](https://github.com/vladfaust/callbacks.cr/releases) and change the `version` accordingly.

## Usage

This shards allows validation composition (i.e. inclusion of modules with custom validations and rules).

```crystal
require "validations"

module CustomValidations
  include Validations

  rule :email do |attr, value, rule|
    invalidate(attr, "must be an email") unless /@/.match(value)
  end
end

struct User
  include Validations
  include CustomValidations

  property name : String
  property email : String
  @age : UInt8?
  @nilable : String?

  def initialize(@name, @email, @age : UInt8? = nil, @nilable : String? = nil)
  end

  validate name, size: (1..16)
  validate email, size: (6..64), email: true
  validate @age, gte: 18

  # Will not be run if `@nilable.nil?`
  validate @nilable, size: (5..10)

  # Custom validations are allowed
  def validate
    previous_def
    invalidate("name", "must not be equal to Vadim") if name == "Vadim"
  end
end

user = User.new("Vadim", "e-mail", 17)
user.valid? # false
pp user.invalid_attributes
# {
#   "name" => ["must have size in (1..16)", "must not be equal to Vadim"],
#   "email" => ["must have size in (6..64)", "must be an email"],
#   "@age" => ["must be greater than or equal to 18"]
# }
```

### Currently implemented inline validations

* `is: Object` - check if `attribute == object`
* `gte: Comparable` - check if `attribute >= comparable`
* `lte: Comparable` - check if `attribute <= comparable`
* `gt: Comparable` - check if `attribute > comparable`
* `lt: Comparable` - check if `attribute < comparable`
* `in: Enumerable` - check if `enumerable.includes?(attribute)`
* `size: Enumerable` - check if `enumerable.includes?(attribute.size)`
* `size: Int` - check if `attribute.size == int`
* `regex: Regex` - check if `regex.match(attribute)`

## Contributing

1. Fork it (<https://github.com/vladfaust/validations.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [@vladfaust](https://github.com/vladfaust) Vlad Faust - creator, maintainer
