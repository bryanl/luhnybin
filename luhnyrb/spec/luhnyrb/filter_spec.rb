require 'spec_helper'

describe Luhnyrb::Filter do

  it "matches a valid 14-digit #" do
    filter = Luhnyrb::Filter.new
    text = "56613959932537\n"
    lambda {filter.filter(text)}.must_output("XXXXXXXXXXXXXX\n")
  end

  it "matches a valid 15-digit #" do
    filter = Luhnyrb::Filter.new
    text = "508733740140655\n"
    lambda {filter.filter(text)}.must_output("XXXXXXXXXXXXXXX\n")
  end

  it "matches a valid 16-digit #" do
    filter = Luhnyrb::Filter.new
    text = "6853371389452376\n"
    lambda {filter.filter(text)}.must_output("XXXXXXXXXXXXXXXX\n")
  end

  it "doesn't filter an invalid 14-digit #" do
    filter = Luhnyrb::Filter.new
    text = "49536290423965\n"
    lambda {filter.filter(text)}.must_output("49536290423965\n")
  end

  it "doesn't filter an invalid 15-digit #" do
    filter = Luhnyrb::Filter.new
    text = "495362904239659\n"
    lambda {filter.filter(text)}.must_output("495362904239659\n")
  end

  it "doesn't filter an invalid 16-digit #" do
    filter = Luhnyrb::Filter.new
    text = "4953629042339659\n"
    lambda {filter.filter(text)}.must_output("4953629042339659\n")
  end

  it "doesn't filter unknown text" do
    filter = Luhnyrb::Filter.new
    text = "foo bar baz\n"
    lambda {filter.filter(text)}.must_output(text)
  end

end
