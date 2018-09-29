module Validations
  protected def validate_in(attr, value, in)
    return if value.nil?
    invalidate(attr, "must be in #{in}") unless in.includes?(value)
  end
end
