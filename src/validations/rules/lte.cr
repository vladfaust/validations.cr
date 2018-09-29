module Validations
  protected def validate_lte(attr, value, lte)
    return if value.nil?
    invalidate(attr, "must be less than or equal to #{lte}") unless value <= lte
  end
end
