module Validations
  protected def validate_presence(attr, value, rule : Bool)
    if rule
      invalidate(attr, "must be present") if value.nil?
    else
      invalidate(attr, "must not be present") unless value.nil?
    end
  end
end
