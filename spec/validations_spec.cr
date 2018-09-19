require "./spec_helper"

struct User
  include Validations

  enum Sex
    Male
    Female
  end

  property name : String
  property email : String
  @age : UInt8?
  @sex : Sex
  @inches : Float32? # Length of a user's... hair
  property country : String?
  setter age, sex, inches

  def initialize(@name, @email, @sex : Sex, @age : UInt8? = nil, @inches : Float32? = nil, @country : String? = nil)
  end

  validate name, size: (1..16)
  validate email, size: (6..64), regex: /\w+@\w+\.\w{2,}/
  validate @age, gte: 18
  validate @sex, is: Sex::Male    # It's, um, boys' club
  validate @inches, in: (6.5..20) # Only those guys with long hair are accepted
  validate country, size: 2

  def validate
    previous_def # Don't forget that

    invalidate("name", "must not be equal to Vadim") if name == "Vadim" # Cheeki-Breeki
  end
end

describe User do
  ideal = User.new(name: "Vlad", email: "mail@vladfaust.com", age: 22, sex: :male, country: "ru")

  context "when valid" do
    it "is valid" do
      ideal.valid?.should be_true
    end

    it "has empty invalid_attributes" do
      ideal.invalid_attributes.empty?.should be_true
    end
  end

  context "when with invalid name" do
    user = ideal.dup
    user.name = "Uvuvwevwevwe Onyetenyevwe Ugwemubwem Ossas"

    it "is invalid" do
      user.valid?.should be_false
    end

    it "raises" do
      expect_raises Validations::Error do
        user.valid!
      end
    end

    it "has name in invalid_attributes" do
      user.invalid_attributes.should eq ({"name" => ["must have size in (1..16)"]})
    end
  end

  describe "custom validations" do
    context "when with restricted name" do
      user = ideal.dup
      user.name = "Vadim"

      it "is invalid" do
        user.valid?.should be_false
      end

      it "has name in invalid_attributes" do
        user.invalid_attributes.should eq ({"name" => ["must not be equal to Vadim"]})
      end
    end
  end

  context "when with invalid email" do
    user = ideal.dup
    user.email = "h@ck"

    it "is invalid" do
      user.valid?.should be_false
    end

    it "has email in invalid_attributes" do
      user.invalid_attributes.should eq ({"email" => [
        "must have size in (6..64)",
        "must match /\\w+@\\w+\\.\\w{2,}/",
      ]})
    end
  end

  context "when with invalid age" do
    user = ideal.dup
    user.age = 17_u8

    it "is invalid" do
      user.valid?.should be_false
    end

    it "has age in invalid_attributes" do
      user.invalid_attributes.should eq ({"@age" => ["must be greater than or equal to 18"]})
    end
  end

  context "when with invalid sex" do
    user = ideal.dup
    user.sex = User::Sex::Female

    it "is invalid" do
      user.valid?.should be_false
    end

    it "has sex in invalid_attributes" do
      user.invalid_attributes.should eq ({"@sex" => ["must be equal to Sex::Male"]})
    end
  end

  context "when with too long hair" do
    user = ideal.dup
    user.inches = 29.5_f32

    it "is invalid" do
      user.valid?.should be_false
    end

    it "has inches in invalid_attributes" do
      user.invalid_attributes.should eq ({"@inches" => ["must be in (6.5..20)"]})
    end
  end

  context "when with invalid country" do
    user = ideal.dup
    user.country = "rus"

    it "is invalid" do
      user.valid?.should be_false
    end

    it "has country in invalid_attributes" do
      user.invalid_attributes.should eq ({"country" => ["must have size equal to 2"]})
    end
  end
end
