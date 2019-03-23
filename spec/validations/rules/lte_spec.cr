require "../../spec_helper"

record LTEObject, x : Int32

struct LTEObject
  include Validations
  validate x, lte: 5
end

describe ":lte" do
  context "when valid" do
    o = LTEObject.new(5)

    it do
      o.valid?.should be_true
      o.invalid_attributes.should be_nil
    end
  end

  context "when invalid" do
    o = LTEObject.new(6)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must be less than or equal to 5"]})
    end
  end
end
