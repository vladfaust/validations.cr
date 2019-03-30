require "uri"

module Validations
  protected def validate_scheme(attr, value, scheme : String | Enumerable(String))
    return if value.nil?

    value_scheme = URI.parse(value).scheme
    return if value_scheme.nil?

    case scheme
    when String
      invalidate(attr, "must have scheme equal to #{scheme}") if value_scheme != scheme
    else
      invalidate(attr, "must have scheme in #{scheme}") unless scheme.includes?(value_scheme)
    end
  end
end
