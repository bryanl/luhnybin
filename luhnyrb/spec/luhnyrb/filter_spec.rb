require 'spec_helper'

describe Luhnyrb::Filter do

  it "matches a valid 14-digit #" do
    filter = Luhnyrb::Filter.new
    text = "56613959932537\n"
    filter.filter(text).must_equal("XXXXXXXXXXXXXX")
  end

  it "matches a valid 15-digit #" do
    filter = Luhnyrb::Filter.new
    text = "508733740140655\n"
    filter.filter(text).must_equal("XXXXXXXXXXXXXXX")
  end

  it "matches a valid 16-digit #" do
    filter = Luhnyrb::Filter.new
    text = "6853371389452376\n"
    filter.filter(text).must_equal("XXXXXXXXXXXXXXXX")
  end

  it "doesn't filter an invalid 14-digit #" do
    filter = Luhnyrb::Filter.new
    text = "49536290423965\n"
    filter.filter(text).must_equal("49536290423965")
  end

  it "doesn't filter an invalid 15-digit #" do
    filter = Luhnyrb::Filter.new
    text = "495362904239659\n"
    filter.filter(text).must_equal("495362904239659")
  end

  it "doesn't filter an invalid 16-digit #" do
    filter = Luhnyrb::Filter.new
    text = "4953629042339659\n"
    filter.filter(text).must_equal("4953629042339659")
  end

  it "filters the matched part of a string" do
    filter = Luhnyrb::Filter.new
    text = "1256613959932537\n"
    filter.filter(text).must_equal("12XXXXXXXXXXXXXX")
  end

  it "doesn't filter unknown text" do
    filter = Luhnyrb::Filter.new
    text = "foo bar baz\n"
    filter.filter(text).must_equal("foo bar baz")
  end

end
