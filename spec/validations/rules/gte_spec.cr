require "../../spec_helper"

record GTEObject, x : Int32

struct GTEObject
  include Validations
  validate x, gte: 5
end

describe ":gte" do
  context "when valid" do
    o = GTEObject.new(5)

    it do
      o.valid?.should be_true
      o.invalid_attributes.empty?.should be_true
    end
  end

  context "when invalid" do
    o = GTEObject.new(4)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must be greater than or equal to 5"]})
    end
  end
end
