module Validations
  protected def validate_gte(attr, value, gte)
    return if value.nil?
    invalidate(attr, "must be greater than or equal to #{gte}") unless value >= gte
  end
end
