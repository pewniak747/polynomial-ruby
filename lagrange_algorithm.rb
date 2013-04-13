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
      points.map.with_index { |_, m|
        unless(j == m)
          (point - points[m])/(points[j] - points[m])
        end
      }.compact.reduce(:*)
    }
  end
end
