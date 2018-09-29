module Validations
  protected def validate_regex(attr, value, regex)
    return if value.nil?
    invalidate(attr, "must match #{regex.source}") unless regex.match(value)
  end
end
