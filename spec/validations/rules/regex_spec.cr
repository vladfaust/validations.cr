require "../../spec_helper"

record RegexObject, x : String

struct RegexObject
  include Validations
  validate x, regex: /@/
end

describe ":regex" do
  it do
    RegexObject.new("foo@bar").valid?.should be_true
    RegexObject.new("foo").valid?.should be_false
  end
end
