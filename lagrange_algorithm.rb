class LagrangeAlgorithm
  attr_accessor :points, :values

  def initialize(input)
    self.points = input.map { |a, _| a }
    self.values = input.map { |_, b| b }
  end

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

