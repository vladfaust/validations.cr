class Hash(K, V)
  # Fetch *key* or set it to *value*.
  #
  # ```
  # h = {"foo" => "bar"}
  # h.fetch_or_set("foo", "baz"); pp h
  # # {"foo" => "bar"}
  # h.fetch_or_set("bar", "baz"); pp h
  # # {"foo" => "bar", "bar" => "baz"}
  # ```
  def fetch_or_set(key, value)
    if has_key?(key)
      self.[key]
    else
      self.[key] = value
    end
  end
end

# Enables the including type to define attribute validations.
#
# ```
# struct User
#   include Validations
#
#   property name : String
#   property email : String
#   @age : UInt8?
#   @nilable : String?
#
#   def initialize(@name, @email, @age : UInt8? = nil, @nilable : String? = nil)
#   end
#
#   validate name, size: (1..16)
#   validate email, size: (6..64), regex: /\w+@\w+\.\w{2,}/
#   validate @age, gte: 18
#
#   # Will not be run if `@nilable.nil?`
#   validate @nilable, size: (5..10)
#
#   # Custom validations are allowed
#   def validate
#     previous_def
#     invalidate("name", "must not be equal to Vadim") if name == "Vadim"
#   end
# end
#
# user = User.new("Vadim", "e-mail", 17)
# pp user.valid?
# # false
# pp user.invalid_attributes
# # {
# #   "name" => ["must have size in (1..16)", "must not be equal to Vadim"],
# #   "email" => ["must have size in (6..64)", "must match /\\w+@\\w+\\.\\w{2,}/"],
# #   "@age" => ["must be greater than or equal to 18"]
# # }
# ```
module Validations
  # Gently check if the including type is valid.
  def valid?
    validate
    invalid_attributes.empty?
  end

  # Roughly check if the including type is valid, raising `Error` otherwise.
  def valid!
    valid? || raise Error.new(invalid_attributes)
    self
  end

  # A hash of invalid attributes, if any.
  #
  # Example:
  #
  # ```
  # pp user.invalid_attributes
  # # {"name" => ["is too long"], ["is not Slav enough"]}
  # ```
  getter invalid_attributes = Hash(String, Array(String)).new

  # Raised when the including type has validation errors after calling `valid!`.
  class Error < Exception
    # A hash of invalid attributes, similar to `Validations#invalid_attributes`.
    getter invalid_attributes : Hash(String, Array(String))

    def initialize(@invalid_attributes)
    end
  end

  macro included
    {% unless @type.has_method?("validate") %}
      # Run validations, clearing `#invalid_attributes` before.
      def validate
        invalid_attributes.clear
      end
    {% end %}
  end

  # Mark *attribute* as invalid with *message*.
  macro invalidate(attribute, message)
    invalid_attributes.fetch_or_set({{attribute}}, Array(String).new).push({{message}})
  end

  # Validate *attribute* with inline *rules* unless it's `nil`.
  #
  # ```
  # validate name, size: (1..16)
  # validate email, regex: /\w+@\w+\.\w{2,}/
  # validate age, gte: 18
  # ```
  #
  # List of currently implemented inline rules:
  #
  # * `is: Object` - check if `attribute == object`
  # * `gte: Comparable` - check if `attribute >= comparable`
  # * `lte: Comparable` - check if `attribute <= comparable`
  # * `gt: Comparable` - check if `attribute > comparable`
  # * `lt: Comparable` - check if `attribute < comparable`
  # * `in: Enumerable` - check if `enumerable.includes?(attribute)`
  # * `size: Enumerable` - check if `enumerable.includes?(attribute.size)`
  # * `size: Int` - check if `attribute.size == int`
  # * `regex: Regex` - check if `regex.match(attribute)`
  #
  # The `#validate` method can also be redefined to run custom validations:
  #
  # ```
  # def validate
  #   previous_def # Mandatory, otherwise previous validations won't run
  #   invalidate("name", "some error") if name == "Foo"
  # end
  # ```
  macro validate(attribute, **rules)
    def validate
      previous_def

      unless {{attribute.id}}.nil?
        value = {{attribute.id}}.not_nil!

        {% if rules[:is] %}
          invalidate({{attribute.stringify}}, "must be equal to {{rules[:is]}}") unless value == {{rules[:is]}}
        {% end %}

        {% if rules[:gte] %}
          invalidate({{attribute.stringify}}, "must be greater than or equal to {{rules[:gte]}}") unless value >= {{rules[:gte]}}
        {% end %}

        {% if rules[:lte] %}
          invalidate({{attribute.stringify}}, "must be less than or equal to {{rules[:lte]}}") unless value <= {{rules[:lte]}}
        {% end %}

        {% if rules[:gt] %}
          invalidate({{attribute.stringify}}, "must be greater than {{rules[:gt]}}") unless value > {{rules[:gt]}}
        {% end %}

        {% if rules[:lt] %}
          invalidate({{attribute.stringify}}, "must be less than {{rules[:lt]}}") unless value < {{rules[:lt]}}
        {% end %}

        {% if rules[:in] %}
          invalidate({{attribute.stringify}}, "must be in {{rules[:in]}}") unless {{rules[:in]}}.includes?(value)
        {% end %}

        {% if rules[:size] %}
          {% if rules[:size].is_a?(Expressions) && rules[:size].expressions.first.is_a?(RangeLiteral) %}
            invalidate({{attribute.stringify}}, "must have size in {{rules[:size]}}") unless {{rules[:size]}}.includes?(value.size)
          {% elsif rules[:size].is_a?(NumberLiteral) && rules[:size].kind == :i32 %}
            invalidate({{attribute.stringify}}, "must have size equal to {{rules[:size]}}") unless value.size == {{rules[:size]}}
          {% else %}
            {% raise "'size:' validation must have Enumerable or Int32 as argument. Given: #{rules[:size]}" %}
          {% end %}
        {% end %}

        {% if rules[:regex] %}
          invalidate({{attribute.stringify}}, "must match " + {{rules[:regex].stringify}}) unless ({{rules[:regex]}}).match(value)
        {% end %}
      end
    end
  end
end
