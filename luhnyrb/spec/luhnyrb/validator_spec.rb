require 'spec_helper'

describe Luhnyrb::Validator do

  it "returns true if the number is valid" do
    number = "4111111111111111"
    validator = Luhnyrb::Validator.new
    validator.validate(number).must_equal true
  end

  it "returns true if the check digits add up to over 10" do
    number = "56613959932537"
    validator = Luhnyrb::Validator.new
    validator.validate(number).must_equal true
  end

  it "returns false if the number is invalid" do
    number = "4911111111111112"
    validator = Luhnyrb::Validator.new
    validator.validate(number).must_equal false
  end

end
