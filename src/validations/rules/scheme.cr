require "URI"

module Validations
  protected def validate_scheme(attr, value, scheme : String | Array(String))
    return if value.nil?
    value_scheme = URI.parse(value).scheme
    return if value_scheme.nil?
    case scheme
    when String
      invalidate(attr, "must have scheme equal to #{scheme}") if value_scheme != scheme
    when Array(String)
      invalidate(attr, "must have scheme in #{scheme}") unless scheme.includes?(value_scheme)
    end
  end
end
