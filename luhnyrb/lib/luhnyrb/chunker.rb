module Luhnyrb
  class Chunker
    def initialize(text)
      @text = text
      @current_index = 0
    end

    def chunk(size)
      text = @text[@current_index, size].tap do
        @current_index+=1
      end

      text.length == 0 ? nil : text
    end
  end
end
