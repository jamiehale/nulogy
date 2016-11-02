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

    end

  end

end
