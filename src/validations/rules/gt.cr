module Validations
  protected def validate_gt(attr, value, gt)
    return if value.nil?
    invalidate(attr, "must be greater than #{gt}") unless value > gt
  end
end
