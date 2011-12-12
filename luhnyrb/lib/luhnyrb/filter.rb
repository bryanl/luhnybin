require_relative "validator"

module Luhnyrb
  class Filter

    def initialize
      @validator = Luhnyrb::Validator.new
    end

    def filter(text)
      line = text.chomp
      extract_cards_with_no_spaces(line)
    end

    def extract_cards_with_no_spaces(line)

      [16, 15, 14].each do |size|
        chunker = Luhnyrb::Chunker.new(line)
        while(chunk = chunker.chunk(size))
          if chunk =~ /^\d+$/ && chunk.length == size
            if @validator.validate chunk
              return line.gsub!(/#{chunk}/, "X"*size)
            end
          end
        end
      end

      line
    end

    def validate_string(string, size)
      if @validator.validate string
        "X"*size
      else
        string
      end
    end

  end
end
