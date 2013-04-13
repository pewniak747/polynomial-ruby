require_relative 'interpolation_algorithm'

class NevilleAlgorithm < InterpolationAlgorithm
  def call(point)
    Solution.new(points, values, point).call
  end

  private

  Solution = Struct.new(:points, :values, :point) do
    def call
      at(0, size)
    end

    private

    def at(i, j)
      @at ||= {}
      @at.fetch([i, j]) {
        value = if i == j
          values[i]
        else
          ((points[j]-point)*at(i, j-1)+(point-points[i])*at(i+1,j))/(points[j]-points[i])
        end
        @at[[i, j]] = value
        value
      }
    end

    def size
      points.size - 1
    end
  end
end
