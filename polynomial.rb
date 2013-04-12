require 'bigdecimal'

class Polynomial
  attr_reader :coefficients
  def initialize(coefficients)
    raise "At least one coefficient is required" if coefficients.size == 0
    coefficients = coefficients[0...-1] while coefficients[-1] == 0 && coefficients.size > 1
    @coefficients = Array(coefficients)
  end

  def degree
    coefficients.size - 1
  end

  def +(other)
    if other.kind_of?(Numeric)
      self + self.class.new([other])
    elsif other.kind_of?(self.class)
      coef = Array.new([other.degree, degree].max + 1) { |i|
        (other.coefficients[i] || 0) + (coefficients[i] || 0)
      }
      self.class.new(coef)
    else
      raise "Cannot sum #{self} with #{other}"
    end
  end

  def *(other)
    if other.kind_of?(Numeric)
      self.class.new(coefficients.map { |c| c * other })
    elsif other.kind_of?(self.class)
      coefficients.map.with_index { |c, idx|
        self.class.new(Array.new(idx, 0) + other.coefficients.map { |o| o * c })
      }.reduce { |sum, p|
        sum + p
      }
    else
      raise "Cannot multiply #{self} by #{other}"
    end
  end

  def -(other)
    self + (other * -1)
  end

  def ==(other)
    if(other.kind_of?(self.class))
      coefficients == other.coefficients
    else super
    end
  end

  def to_s
    coefficients[1..-1].reverse.map.with_index { |c, i|
      sign = if(i != 0)
        if(c > 0) then "+"
        elsif(c < 0) then "-"
        end
      end
      [sign, "#{"%0.5f" % c}x^#{degree-i}"].join(' ') unless c == 0
    }.push(coefficients[0] != 0 ? "+ #{coefficients[0]}" : nil).compact.join(' ')
  end

  def inspect
    "#<Polynomial: #{to_s} >"
  end
end
