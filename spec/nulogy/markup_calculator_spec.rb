require 'spec_helper'

module Nulogy

  describe MarkupCalculator do

    it 'exists' do
      expect{ MarkupCalculator.new }.not_to raise_error
    end

    describe 'once created' do

      let( :calculator ) { MarkupCalculator.new }

      it 'says free stuff is free' do
        expect( calculator.calculate( 0.00, 0 ) ).to eq( 0.00 )
      end

      it 'says non-free stuff gets marked up by the flat rate' do
        expect( calculator.calculate( 1.00, 0 ) ).to eq( 1.00 * 1.05 )
      end

      it 'says 1 person adds a 1.2% markup' do
        expect( calculator.calculate( 1.00, 1 ) ).to eq( 1.00 * 1.05 * 1.012 )
      end

      it 'says 2 people adds a 2.4% markup' do
        expect( calculator.calculate( 1.00, 2 ) ).to eq( 1.00 * 1.05 * 1.024 )
      end

      it 'says 100 people adds a 120% markup' do
        expect( calculator.calculate( 1.00, 100 ) ).to eq( 1.00 * 1.05 * 2.20 )
      end

    end

  end

end
