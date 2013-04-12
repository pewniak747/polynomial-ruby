require 'rspec'
require_relative './polynomial'

describe Polynomial do
  describe "#coefficients" do
    it "should be initialized with array of one coefficient" do
      described_class.new([1]).coefficients.should == [1]
    end

    it "should be initialized with array of some coefficients" do
      described_class.new([1, 2]).coefficients.should == [1, 2]
    end

    it "should not be initialized with no coefficients" do
      expect { described_clas.new([]) }.to raise_error
    end

    it "should ignore leading 0 coefficients" do
      described_class.new([0, 2, 0]).coefficients.should == [0, 2]
    end

    it "should leave one 0 coefficient if all coefficients are 0" do
      described_class.new([0, 0, 0]).coefficients.should == [0]
    end
  end

  describe "#degree" do
    it "should be one less that number of coefficients" do
      described_class.new([1, 2, 3]).degree.should == 2
    end

    it "should ignore leading 0 coefficients" do
      described_class.new([1, 2, 3, 0]).degree.should == 2
    end
  end

  describe "#+" do
    subject(:polynomial) { described_class.new([1, 2, 3]) }

    it "should return new Polynomial instance" do
      (polynomial + 1).should be_instance_of(described_class)
    end

    it "should return equal polynomial when adding 0" do
      (polynomial + 0).coefficients.should == polynomial.coefficients
    end

    it "should add a number to 0th coefficient" do
      (polynomial + 1).coefficients.should == [2, 2, 3]
    end

    it "should sum polynomials with lesser degree" do
      other_polynomial = described_class.new([3, 5])
      (polynomial + other_polynomial).coefficients.should == [4, 7, 3]
    end

    it "should sum polynomials with equal degree" do
      other_polynomial = described_class.new([3, 5, 1])
      (polynomial + other_polynomial).coefficients.should == [4, 7, 4]
    end

    it "should sum polynomials with greater degree" do
      other_polynomial = described_class.new([3, 5, 1, 8])
      (polynomial + other_polynomial).coefficients.should == [4, 7, 4, 8]
    end
  end

  describe "#-" do
    subject(:polynomial) { described_class.new([1, 2, 3]) }

    it "should return new Polynomial instance" do
      (polynomial - 1).should be_instance_of(described_class)
    end

    it "should return equal polynomial when subtracting 0" do
      (polynomial - 0).coefficients.should == polynomial.coefficients
    end

    it "should subtract a number from 0th coefficient" do
      (polynomial - 1).coefficients.should == [0, 2, 3]
    end

    it "should subtract polynomials with lesser degree" do
      other_polynomial = described_class.new([3, 5])
      (polynomial - other_polynomial).coefficients.should == [-2, -3, 3]
    end

    it "should sum polynomials with equal degree" do
      other_polynomial = described_class.new([3, 5, 1])
      (polynomial - other_polynomial).coefficients.should == [-2, -3, 2]
    end

    it "should sum polynomials with greater degree" do
      other_polynomial = described_class.new([3, 5, 1, 8])
      (polynomial - other_polynomial).coefficients.should == [-2, -3, 2, -8]
    end
  end

  describe "#*" do
    subject(:polynomial) { described_class.new([1, 2, 3]) }

    it "should return new Polynomial instance" do
      (polynomial * 1).should be_instance_of(described_class)
    end

    it "should return equal polynomial when multiplying by 1" do
      (polynomial * 1).coefficients.should == polynomial.coefficients
    end

    it "should return 0 polynomial when multiplying by 0" do
      (polynomial * 0).coefficients.should == [0]
    end

    it "should multiply all coefficients if multiplying by a number" do
      (polynomial * 2).coefficients.should == [2, 4, 6]
    end

    it "should return proper polynomial when multiplying by polynomial with lesser degree" do
      other_polynomial = described_class.new([3, 5])
      (polynomial * other_polynomial).coefficients.should == [3, 11, 19, 15]
    end

    it "should return proper polynomial when multiplying by polynomial with equal degree" do
      other_polynomial = described_class.new([3, 5, 2])
      (polynomial * other_polynomial).coefficients.should == [3, 11, 21, 19, 6]
    end

    it "should return proper polynomial when multiplying by polynomial with greater degree" do
      other_polynomial = described_class.new([3, 5, 2, 4])
      (polynomial * other_polynomial).coefficients.should == [3, 11, 21, 23, 14, 12]
    end
  end

  describe "#==" do
    subject(:polynomial) { described_class.new([1, 2, 3]) }

    it "should be true when coefficients are the same" do
      other_polynomial = described_class.new([1, 2, 3])
      (polynomial == other_polynomial).should be_true
    end

    it "should be false when coefficients are different" do
      other_polynomial = described_class.new([1, 2, 0])
      (polynomial == other_polynomial).should be_false
    end

    it "should be false when comparing with other object" do
      (polynomial == Object.new).should be_false
    end
  end
end
