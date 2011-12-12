require_relative "validator"

module Luhnyrb
  class Filter

    FILTERS = [:extract_all_zeros,
               :extract_cards_with_no_spaces,
               [:extract_cards_with_spaces, " "],
               [:extract_cards_with_spaces, "-"]]

    def initialize
      @validator = Luhnyrb::Validator.new
    end

    def filter(text)
      @line_changed = true
      line = text.chomp

      filtered_line = line
      while @line_changed
        filtered_line = run_filters(filtered_line)
      end

      filtered_line
    end

    def run_filters(line)
      @line_changed = false
      new_line = line.dup
      FILTERS.each do |f|
        new_line = send *[f, new_line].flatten
        @line_changed = true if new_line != line
      end
      new_line
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

    def extract_cards_with_spaces(delimiter, line)
      line.match(%r{\d{4}#{delimiter}\d{4}#{delimiter}\d{4}#{delimiter}\d{4}}) do |m|
        m.to_a.each do |numbers|
          if @validator.validate numbers.gsub(%r{#{delimiter}}, '')
            line.gsub!(%r{#{numbers}}, "XXXX#{delimiter}XXXX#{delimiter}XXXX#{delimiter}XXXX")
          end
        end
      end

      line
    end

    def extract_all_zeros(line)
      all_zeros = %r{0{1000,}}

      line.match(all_zeros) do |m|
        m.to_a.each do |zeros|
          line.gsub! all_zeros, "X"*zeros.length
        end
      end

      line
    end

  end
end
