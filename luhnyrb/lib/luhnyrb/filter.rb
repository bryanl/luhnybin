require_relative "validator"

module Luhnyrb
  class Filter

    def initialize
      @validator = Luhnyrb::Validator.new
    end

    def filter(text)
      line = text.chomp
      newtext = if line =~ %r{^\d{14}$}
                  validate_string(line, 14)
                elsif line =~ %r{^\d{15}$}
                  validate_string(line, 15)
                elsif line =~ %r{^\d{16}$}
                  validate_string(line, 16)
                else
                  line
                end

      puts newtext
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
