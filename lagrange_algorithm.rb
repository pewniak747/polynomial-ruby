require_relative 'interpolation_algorithm'

class LagrangeAlgorithm < InterpolationAlgorithm
  def call(point)
    basis_polynomials(point).zip(values)
                     .map { |p, v| p * v }
                     .reduce(:+)
  end

  private

  def basis_polynomials(point)
    Array.new(points.size) { |j|
      numerator = BigDecimal(1)
      denominator = BigDecimal(1)
      points.each_with_index { |el, m|
        numerator *= (point - points[m]) unless(j == m)
      }
      points.each_with_index { |el, m|
        denominator *= (points[j] - points[m]) unless(j == m)
      }
      numerator / denominator
    }
  end
end
