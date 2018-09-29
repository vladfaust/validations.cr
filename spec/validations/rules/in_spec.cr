require "../../spec_helper"

record InObject, x : Int32

struct InObject
  include Validations
  validate x, in: {1, 2}
end

describe ":in" do
  it do
    InObject.new(1).valid?.should be_true
    InObject.new(3).valid?.should be_false
  end
end
