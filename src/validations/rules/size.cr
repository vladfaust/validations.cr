module Validations
  protected def validate_size(attr, value, size : Range | Int)
    return if value.nil?
    case size
    when Range
      invalidate(attr, "must have size in #{size}") unless size.includes?(value.size)
    when Int
      invalidate(attr, "must have size equal to #{size}") unless value.size == size
    end
  end
end
