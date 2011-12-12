require 'spec_helper'

describe Luhnyrb::Chunker do

  it "chunks up text" do
    text = "this is a longer string of text for testing"
    chunker = Luhnyrb::Chunker.new(text)
    chunker.chunk(14).must_equal("this is a long")
    chunker.chunk(14).must_equal("his is a longe")
  end

  it "returns nil when we have no more text to chunk" do
    text = "s"
    chunker = Luhnyrb::Chunker.new(text)
    chunker.chunk(1).must_equal("s")
    chunker.chunk(1).must_equal(nil)

  end

end
