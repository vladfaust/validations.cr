require "../../spec_helper"

record GTObject, x : Int32

struct GTObject
  include Validations
  validate x, gt: 5
end

describe ":gt" do
  context "when valid" do
    o = GTObject.new(6)

    it do
      o.valid?.should be_true
      o.invalid_attributes.empty?.should be_true
    end
  end

  context "when invalid" do
    o = GTObject.new(5)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must be greater than 5"]})
    end
  end
end
