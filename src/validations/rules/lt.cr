module Validations
  protected def validate_lt(attr, value, lt)
    return if value.nil?
    invalidate(attr, "must be less than #{lt}") unless value < lt
  end
end
