require 'scanf'
require 'bigdecimal'

require_relative "./lagrange_polynomial"
require_relative "./lagrange_algorithm"
require_relative "./neville_algorithm"

points_count = scanf("%d")[0]
points = Array.new(points_count) {
  scan = scanf("%s%s")
  [BigDecimal(scan[0]), BigDecimal(scan[1])]
}

point = BigDecimal(scanf("%s")[0])

lagrange_polynomial = LagrangePolynomial.new(points).call
lagrange_solution   = LagrangeAlgorithm.new(points).call(point)
neville_solution    = NevilleAlgorithm.new(points).call(point)

puts "Lagrange polynomial:                   #{lagrange_polynomial}"
puts "Lagrange algorithm solution for #{point}: #{"%0.5f" % lagrange_solution}"
puts "Neville algorithm solution for #{point}:  #{"%0.5f" % neville_solution}"
