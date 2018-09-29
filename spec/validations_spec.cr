require "./spec_helper"

module CustomValidations
  include Validations

  rule :size_not_square_of do |attr, val, rule|
    invalidate(attr, "must not have a size equal to the square of #{rule}") if val.size == rule ** 2
  end

  macro included
    def validate
      previous_def
      invalidate("x", "must not be bar") if x == "bar"
    end
  end
end

record ObjectToValidate, x : String

struct ObjectToValidate
  include Validations
  include CustomValidations

  rule custom_rule do |attr, val|
    invalidate(attr, "must not be baz") if val == "baz"
  end

  validate x, size: (1..10), size_not_square_of: 3, custom_rule: true

  def validate
    previous_def
    invalidate("x", "must not be qux") if x == "qux"
  end
end

describe Validations do
  it do
    ObjectToValidate.new("aaa").valid?.should be_true
  end

  describe "custom rules" do
    o = ObjectToValidate.new("baz")

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must not be baz"]})
    end
  end

  describe "custom included rules" do
    o = ObjectToValidate.new("f" * 9)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must not have a size equal to the square of 3"]})
    end
  end

  describe "custom #validate" do
    o = ObjectToValidate.new("qux")

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must not be qux"]})
    end
  end

  describe "custom included #validate" do
    o = ObjectToValidate.new("bar")

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must not be bar"]})
    end
  end

  describe "#valid!" do
    it "returns self when valid" do
      ObjectToValidate.new("aaa").valid!.should be_a(ObjectToValidate)
    end

    it "raises when invalid" do
      expect_raises Validations::Error do
        ObjectToValidate.new("baz").valid!
      end
    end
  end

  describe "#invalid_attributes" do
    it "contains invalid attributes" do
      x = ObjectToValidate.new("baz")
      x.validate
      x.invalid_attributes.should eq ({"x" => ["must not be baz"]})
    end
  end
end
