require 'spec_helper'

module Nulogy

  describe MarkupCalculator do

    it 'exists' do
      expect{ MarkupCalculator.new }.not_to raise_error
    end

    describe 'once created' do

      let( :calculator ) { MarkupCalculator.new }

      FLAT_RATE = 1.05
      PEOPLE_RATE = 0.012
      PHARMACEUTICALS_RATE = 0.075
      FOOD_RATE = 0.13
      ELECTRONICS_RATE = 0.02

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
          output: FLAT_RATE
        },
        {
          description: '1 person adds a 1.2% markup',
          base: 1.00,
          people: 1,
          output: FLAT_RATE * ( 1.00 + PEOPLE_RATE )
        },
        {
          description: '2 people add a 2.4% markup',
          base: 1.00,
          people: 2,
          output: FLAT_RATE * ( 1.00 + 2 * PEOPLE_RATE )
        },
        {
          description: '100 people adds a 120% markup',
          base: 1.00,
          people: 100,
          output: FLAT_RATE * ( 1.00 + 100 * PEOPLE_RATE )
        }
      ].each do |example|
        it "says #{example[:description]}" do
          expect( calculator.calculate( example[ :base ], example[ :people ] ) ).to eq( example[ :output ] )
        end
      end

      it 'adds 7.5% for pharmaceuticals' do
        expect( calculator.calculate( 1.00, 0, [ :pharmaceuticals ] ) ).to eq( FLAT_RATE * ( 1.00 + PHARMACEUTICALS_RATE ) )
      end

      it 'adds 13% for food' do
        expect( calculator.calculate( 1.00, 0, [ :food ] ) ).to eq( FLAT_RATE * ( 1.00 + FOOD_RATE ) )
      end

      it 'adds both a 13% -and- 7.5% (20.5% total) for products flagged food and pharmaceuticals' do
        expect( calculator.calculate( 1.00, 0, [ :food, :pharmaceuticals ] ) ).to eq( FLAT_RATE * ( 1.00 + FOOD_RATE + PHARMACEUTICALS_RATE ) )
      end

      it 'adds 2% for electronics' do
        expect( calculator.calculate( 1.00, 0, [ :electronics ] ) ).to eq( FLAT_RATE * ( 1.00 + ELECTRONICS_RATE ) )
      end

      it 'adds no material rate for other material types' do
        expect( calculator.calculate( 1.00, 0, [ :books ] ) ).to eq( FLAT_RATE )
      end

    end

  end

end
