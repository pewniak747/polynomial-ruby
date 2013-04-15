require_relative './polynomial'

class LagrangePolynomial
  attr_accessor :points, :values

  def initialize(input)
    self.points = input.map { |a, _| a }
    self.values = input.map { |_, b| b }
  end

  def call
    basis_polynomials.zip(values)
                     .map { |p, v| p * v }
                     .reduce(:+)
  end

  private

  def basis_polynomials
    Array.new(points.size) { |j|
      numerator = Polynomial.new([BigDecimal(1)])
      denominator = BigDecimal(1)
      points.each_with_index { |el, m|
        numerator *= Polynomial.new([BigDecimal(0), BigDecimal(1)]) - el unless(j == m)
      }
      points.each_with_index { |el, m|
        denominator *= (points[j] - points[m]) unless(j == m)
      }
      numerator / denominator
    }
  end
end

