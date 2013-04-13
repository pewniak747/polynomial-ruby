class InterpolationAlgorithm
  attr_accessor :points, :values

  def initialize(input)
    self.points = input.map { |a, _| a }
    self.values = input.map { |_, b| b }
  end

  def call(point)
    raise NotImplementedError, "Implement #call in #{self.class}"
  end
end
