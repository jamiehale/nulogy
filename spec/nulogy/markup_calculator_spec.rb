require 'spec_helper'

module Nulogy

  describe MarkupCalculator do

    it 'exists' do
      expect{ MarkupCalculator.new }.not_to raise_error
    end

    describe 'once created' do

      it 'says free stuff is free' do
        expect( MarkupCalculator.new.calculate( 0.00 ) ).to eq( 0.00 )
      end

      it 'says non-free stuff gets marked up by the flat rate' do
        expect( MarkupCalculator.new.calculate( 1.00 ) ).to eq( 1.05 )
      end

    end

  end

end
