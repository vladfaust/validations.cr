module Validations
  protected def validate_is(attr, value, is)
    return if value.nil?
    invalidate(attr, "must be equal to #{is}") unless value == is
  end
end
