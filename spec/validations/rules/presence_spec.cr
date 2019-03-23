require "../../spec_helper"

record PresenceObject, x : Int32?
record InversePresenceObject, x : Int32?

struct PresenceObject
  include Validations
  validate x, presence: true
end

struct InversePresenceObject
  include Validations
  validate x, presence: false
end

describe "presence: true" do
  context "when valid" do
    o = PresenceObject.new(6)

    it do
      o.valid?.should be_true
      o.invalid_attributes.should be_nil
    end
  end

  context "when invalid" do
    o = PresenceObject.new(nil)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must be present"]})
    end
  end
end

describe "presence: false" do
  context "when valid" do
    o = InversePresenceObject.new(nil)

    it do
      o.valid?.should be_true
      o.invalid_attributes.should be_nil
    end
  end

  context "when invalid" do
    o = InversePresenceObject.new(6)

    it do
      o.valid?.should be_false
      o.invalid_attributes.should eq ({"x" => ["must not be present"]})
    end
  end
end
