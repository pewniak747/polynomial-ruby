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
      points.map.with_index { |_, m|
        unless(j == m)
          Polynomial.new([ (-1*points[m])/(points[j] - points[m]), 1/(points[j] - points[m])])
        end
      }.compact.reduce(:*)
    }
  end
end

