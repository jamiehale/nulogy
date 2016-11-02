require 'spec_helper'

module Nulogy

  describe MarkupCalculator do

    RATES = {
      flat: 0.05,
      people: 0.012,
      materials: {
        pharmaceuticals: 0.075,
        food: 0.13,
        electronics: 0.02
      }
    }

    it 'is created with a dictionary of rates' do
      expect{ MarkupCalculator.new( RATES ) }.not_to raise_error
    end

    describe 'once created' do

      let( :calculator ) { MarkupCalculator.new( RATES ) }

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
          materials: [],
          output: 0.00
        },
        {
          description: 'non-free stuff gets marked up by the flat rate of 5%',
          base: 1.00,
          people: 0,
          materials: [],
          output: FLAT_RATE
        },
        {
          description: '1 person adds a 1.2% markup',
          base: 1.00,
          people: 1,
          materials: [],
          output: FLAT_RATE * ( 1.00 + PEOPLE_RATE )
        },
        {
          description: '2 people add a 2.4% markup',
          base: 1.00,
          people: 2,
          materials: [],
          output: FLAT_RATE * ( 1.00 + 2 * PEOPLE_RATE )
        },
        {
          description: '100 people adds a 120% markup',
          base: 1.00,
          people: 100,
          materials: [],
          output: FLAT_RATE * ( 1.00 + 100 * PEOPLE_RATE )
        },
        {
          description: 'pharmaceuticals add 7.5%',
          base: 1.00,
          people: 0,
          materials: [ :pharmaceuticals ],
          output: FLAT_RATE * ( 1.00 + PHARMACEUTICALS_RATE )
        },
        {
          description: 'food adds 13%',
          base: 1.00,
          people: 0,
          materials: [ :food ],
          output: FLAT_RATE * ( 1.00 + FOOD_RATE )
        },
        {
          description: 'electronics adds 2%',
          base: 1.00,
          people: 0,
          materials: [ :electronics ],
          output: FLAT_RATE * ( 1.00 + ELECTRONICS_RATE )
        },
        {
          description: 'unrecognized materials adds nothing',
          base: 1.00,
          people: 0,
          materials: [ :books ],
          output: FLAT_RATE
        },
        {
          description: 'food and pharmaceuticals adds both 13% and 7.5% (20.5% total)',
          base: 1.00,
          people: 0,
          materials: [ :food, :pharmaceuticals ],
          output: FLAT_RATE * ( 1.00 + PHARMACEUTICALS_RATE + FOOD_RATE )
        },
      ].each do |example|
        it "says #{example[:description]}" do
          expect( calculator.calculate( example[ :base ], example[ :people ], example[ :materials ] ) ).to be_within( 0.001 ).of( example[ :output ] )
        end
      end

    end

  end

end
