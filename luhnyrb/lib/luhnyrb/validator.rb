module Luhnyrb
  class Validator
    def validate(string)
      newstring = string.reverse.split(//)

      newstring.each_with_index do |x,i|
        newstring[i] = checksumable_column?(i) ? checksum(x) : x.to_i
      end

      luhn_verfies(newstring)
    end

    def checksumable_column?(column_index)
      ((column_index+1) % 2) == 0
    end

    def checksum(x)
      (x.to_i * 2).to_s.
        split(//).
        map(&:to_i).
        reduce(:+)
    end

    def luhn_verfies(array)
      array.inject(:+) % 10 == 0
    end
  end
end
