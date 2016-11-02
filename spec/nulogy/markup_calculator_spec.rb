require 'spec_helper'

module Nulogy

  describe MarkupCalculator do

    it 'exists' do
      expect{ MarkupCalculator.new }.not_to raise_error
    end

    describe 'once created' do

      let( :calculator ) { MarkupCalculator.new }

      [
        {
          description: 'free stuff is free',
          base: 0.00,
          people: 0,
          output: 0.00
        },
        {
          description: 'non-free stuff gets marked up by the flat rate of 5%',
          base: 1.00,
          people: 0,
          output: 1.00 * 1.05
        },
        {
          description: '1 person adds a 1.2% markup',
          base: 1.00,
          people: 1,
          output: 1.00 * 1.05 * 1.012
        },
        {
          description: '2 people add a 2.4% markup',
          base: 1.00,
          people: 2,
          output: 1.00 * 1.05 * 1.024
        },
        {
          description: '100 people adds a 120% markup',
          base: 1.00,
          people: 100,
          output: 1.00 * 1.05 * 2.20
        }
      ].each do |example|
        it "says #{example[:description]}" do
          expect( calculator.calculate( example[ :base ], example[ :people ] ) ).to eq( example[ :output ] )
        end
      end

      it 'adds 7.5% for pharmaceuticals' do
        expect( calculator.calculate( 1.00, 0, [ :pharmaceuticals ] ) ).to eq( 1.05 * 1.075 )
      end

      it 'adds 13% for food' do
        expect( calculator.calculate( 1.00, 0, [ :food ] ) ).to eq( 1.05 * 1.13 )
      end

    end

  end

end
