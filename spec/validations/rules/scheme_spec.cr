require "../../spec_helper"
require "../../../src/validations/rules/scheme"

record StringSchemeObject, x : String
record ArrayStringsSchemeObject, x : String

struct StringSchemeObject
  include Validations
  validate x, scheme: "http"
end

struct ArrayStringsSchemeObject
  include Validations
  validate x, scheme: %w(http https)
end

describe ":scheme" do
  context "with string" do
    context "when valid" do
      o = StringSchemeObject.new("http://foo.bar.baz")

      it do
        o.valid?.should be_true
        o.invalid_attributes.should be_nil
      end
    end

    context "when invalid" do
      o = StringSchemeObject.new("ftp://foo@bar.baz")

      it do
        o.valid?.should be_false
        o.invalid_attributes.should eq ({"x" => ["must have scheme equal to http"]})
      end
    end
  end

  context "with array of strings" do
    context "when valid" do
      o = ArrayStringsSchemeObject.new("http://foo.bar.baz")

      it do
        o.valid?.should be_true
        o.invalid_attributes.should be_nil
      end
    end

    context "when invalid" do
      o = ArrayStringsSchemeObject.new("ftp://foo@bar.baz")

      it do
        o.valid?.should be_false
        o.invalid_attributes.should eq ({"x" => ["must have scheme in [\"http\", \"https\"]"]})
      end
    end
  end
end
