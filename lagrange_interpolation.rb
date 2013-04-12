require 'scanf'
require 'bigdecimal'

require_relative "./lagrange_polynomial"

points_count = scanf("%d")[0]
points = Array.new(points_count) {
  scan = scanf("%s%s")
  [BigDecimal(scan[0]), BigDecimal(scan[1])]
}

solution = LagrangePolynomial.new(points).call
puts solution
