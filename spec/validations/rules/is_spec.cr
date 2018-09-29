require "../../spec_helper"

record IsObject, x : Int32

struct IsObject
  include Validations
  validate x, is: 1
end

describe ":is" do
  it do
    IsObject.new(1).valid?.should be_true
    IsObject.new(2).valid?.should be_false
  end
end
