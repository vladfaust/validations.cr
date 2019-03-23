require "../../spec_helper"

record LTObject, x : Int32

struct LTObject
  include Validations
  validate x, lt: 5
end

describe ":lt" do
  context "when valid" do
    o = LTObject.new(4)

    it do
      o.valid?.should be_true
      o.invalid_attributes.should be_nil
    end
  end

  context "when invalid" do
    o = LTObject.new(5)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must be less than 5"]})
    end
  end
end
