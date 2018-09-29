require "../../spec_helper"

record NumberSizeObject, x : String
record RangeSizeObject, x : String

struct NumberSizeObject
  include Validations
  validate x, size: 1
end

struct RangeSizeObject
  include Validations
  validate x, size: (1..2)
end

describe ":size" do
  context "with number" do
    context "when valid" do
      o = NumberSizeObject.new("a")

      it do
        o.valid?.should be_true
        o.invalid_attributes.empty?.should be_true
      end
    end

    context "when invalid" do
      o = NumberSizeObject.new("aa")

      it do
        o.valid?.should be_false
        o.invalid_attributes.should eq ({"x" => ["must have size equal to 1"]})
      end
    end
  end

  context "with range" do
    context "when valid" do
      o = RangeSizeObject.new("a")

      it do
        o.valid?.should be_true
        o.invalid_attributes.empty?.should be_true
      end
    end

    context "when invalid" do
      o = RangeSizeObject.new("aaa")

      it do
        o.valid?.should be_false
        o.invalid_attributes.should eq ({"x" => ["must have size in 1..2"]})
      end
    end
  end
end
