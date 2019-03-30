require "./ext/*"
require "./validations/rules"

# Enables the including type to define attribute validations.
#
# ```
# module CustomValidations
#   include Validations
#
#   rule :custom_rule do |attr, value|
#     invalidate(attr, "must not be foo") if value == "foo"
#   end
#
#   macro included
#     def validate
#       previous_def
#       invalidate("x", "must not be bar") if x == "bar"
#     end
#   end
# end
#
# record ObjectToValidate, x : String
#
# struct ObjectToValidate
#   include Validations
#   include CustomValidations
#
#   rule another_custom_rule do |attr, value|
#     invalidate(attr, "must not be baz") if value == "baz"
#   end
#
#   validate x, size: (1..10), custom_rule: 42, another_custom_rule: true
#
#   def validate
#     previous_def
#     invalidate("x", "must not be qux") if x == "qux"
#   end
# end
#
# o = ObjectToValidate.new("aaa")
# o.valid?             # true
# o.invalid_attributes # {}
#
# o = ObjectToValidate.new("foo")
# o.valid?             # false
# o.invalid_attributes # {"x" => ["must not be foo"]}
# ```
module Validations
  # Soft check if the including type is valid.
  def valid? : Bool
    validate
    invalid_attributes.nil? || invalid_attributes.not_nil!.empty?
  end

  # Strict check if the including type is valid and return `self`,
  # raise `Error` otherwise.
  def valid! : self
    valid? || raise Error.new(invalid_attributes.not_nil!)
    self
  end

  # A hash of invalid attributes, if any. Equals to `nil` by default.
  #
  # ```
  # pp user.invalid_attributes # nil
  #
  # user.name = "Ovuvuevuevue enyetuenwuevue ugbemugbem osas"
  # pp user.valid? # => false
  #
  # pp user.invalid_attributes
  # # {"name" => ["is too long", "is not slav enough"]}
  # ```
  getter invalid_attributes : Hash(String, Array(String)) | Nil

  # Raised when the including type has validation errors after calling `valid!`.
  class Error < Exception
    # A hash of invalid attributes, which is never `nil`.
    getter invalid_attributes : Hash(String, Array(String))

    def initialize(@invalid_attributes : Hash(String, Array(String)))
      super("#{self} validation failed: #{@invalid_attributes}")
    end
  end

  macro included
    {% unless @type.has_method?("validate") %}
      # Run validations, clearing `#invalid_attributes` before.
      def validate
        invalid_attributes = nil
      end
    {% end %}
  end

  # Mark *attribute* as invalid with *message*.
  #
  # ```
  # invalidate("name", "is not valid")
  # ```
  macro invalidate(attribute, message)
    (@invalid_attributes ||= Hash(String, Array(String)).new).fetch_or_set({{attribute}}, Array(String).new).push({{message}})
  end

  # Validate *attribute* with inline *rules*.
  #
  # ```
  # class User
  #   property name, age
  #
  #   validate name, size: (1..16)
  #   validate age, gte: 18
  # end
  # ```
  #
  # Runs `validate_{rule}` for each one of *rules* internally.
  # You can find currently implemented inline rules in `src/validations/rules`.
  # The list of inline rules can be extended with `.rule` macro.
  #
  # The `#validate` method can also be redefined to run custom validations:
  #
  # ```
  # def validate
  #   previous_def # Mandatory, otherwise inline validations won't run
  #   invalidate("name", "some error") if name == "Foo"
  # end
  # ```
  #
  # It also can be redefined in included modules like this:
  #
  # ```
  # module CustomValidations
  #   macro included
  #     def validate
  #       previous_def
  #       invalidate("name", "another error") if name == "Bar"
  #     end
  #   end
  # end
  #
  # class User
  #   include Validations # Still need to include `Validations`
  #   include CustomValidations
  # end
  # ```
  macro validate(attribute, **rules)
    def validate
      {% if @type.has_method?(:validate) %}
        previous_def
      {% end %}

      {% for rule in rules.keys %}
        validate_{{rule.id.gsub(/\s/, "_")}}({{attribute.stringify}}, {{attribute}}, {{rules[rule]}})
      {% end %}
    end
  end

  # Define a custom *rule*.
  #
  # The block will receive three attributes:
  #
  # * attribute name, e.g. `"age"`
  # * actual value, e.g. `20`
  # * rule which is currently applied, e.g. `18` for `gte: 18`
  #
  # Note that some arugments can be ommited in the block argument list (i.e. both `rule do |attr, value|` and `rule do |attr|` are valid as well).
  #
  # ```
  # rule :even do |attr, value, rule|
  #   unless value.nil?
  #     if rule
  #       invalidate(attr, "must be even") unless value.not_nil! % 2 == 0
  #     else
  #       invalidate(attr, "must not be even") if value.not_nil! % 2 == 0
  #     end
  #   end
  # end
  # ```
  #
  # Rules can be defined both in the validated object and in an includable module.
  macro rule(rule, &block)
    protected def validate_{{rule.id.gsub(/\s/, "_")}}(attr, value, rule)
      {% for name, index in %w(attr value rule) %}
        {% if block.args[index] && block.args[index].stringify != name %}
          {{block.args[index]}} = {{name.id}}
        {% end %}
      {% end %}

      {{block.body.id}}
    end
  end
end
