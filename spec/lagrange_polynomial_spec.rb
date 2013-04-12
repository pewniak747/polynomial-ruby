require 'rspec'

require_relative '../lagrange_polynomial'

describe LagrangePolynomial do
  subject(:lagrange_polynomial) { described_class.new([[1.0, 1.0], [2.0, 4.0], [3.0, 9.0]]) }
  it "should be initialized with array of arrays" do
    lagrange_polynomial.should be_instance_of(described_class)
  end

  describe "#call" do
    it "should return a Polynomial" do
      lagrange_polynomial.call.should be_instance_of(Polynomial)
    end

    it "should interpolate correct function" do
      lagrange_polynomial.call.should == Polynomial.new([0, 0, 1])
    end
  end

end
