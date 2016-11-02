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
          output: 1.00 + RATES[ :flat ]
        },
        {
          description: '1 person adds a 1.2% markup',
          base: 1.00,
          people: 1,
          materials: [],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + RATES[ :people ] )
        },
        {
          description: '2 people add a 2.4% markup',
          base: 1.00,
          people: 2,
          materials: [],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + 2 * RATES[ :people ] )
        },
        {
          description: '100 people adds a 120% markup',
          base: 1.00,
          people: 100,
          materials: [],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + 100 * RATES[ :people ] )
        },
        {
          description: 'pharmaceuticals add 7.5%',
          base: 1.00,
          people: 0,
          materials: [ :pharmaceuticals ],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + RATES[ :materials ][ :pharmaceuticals ] )
        },
        {
          description: 'food adds 13%',
          base: 1.00,
          people: 0,
          materials: [ :food ],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + RATES[ :materials ][ :food ] )
        },
        {
          description: 'electronics adds 2%',
          base: 1.00,
          people: 0,
          materials: [ :electronics ],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + RATES[ :materials ][ :electronics ] )
        },
        {
          description: 'unrecognized materials adds nothing',
          base: 1.00,
          people: 0,
          materials: [ :books ],
          output: 1.00 + RATES[ :flat ]
        },
        {
          description: 'food and pharmaceuticals adds both 13% and 7.5% (20.5% total)',
          base: 1.00,
          people: 0,
          materials: [ :food, :pharmaceuticals ],
          output: ( 1.00 + RATES[ :flat ] ) * ( 1.00 + RATES[ :materials ][ :pharmaceuticals ] + RATES[ :materials ][ :food ] )
        },

        {
          description: 'Example 1: 1299.99, 3 people, food',
          base: 1299.99,
          people: 3,
          materials: [ :food ],
          output: 1591.58
        }
      ].each do |example|
        it "says #{example[:description]}" do
          expect( calculator.calculate( example[ :base ], example[ :people ], example[ :materials ] ) ).to be_within( 0.005 ).of( example[ :output ] )
        end
      end

    end

  end

end
