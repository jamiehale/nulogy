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
    }.freeze

    it 'is created with a dictionary of rates' do
      expect { MarkupCalculator.new( RATES ) }.not_to raise_error
    end

    describe 'invalid rates passed' do

      def rates_without( rate )
        rates = {}
        rates[ :flat ] = 7 unless rate == :flat
        rates[ :people ] = 'ham radio' unless rate == :people
        rates[ :materials ] = {} unless rate == :materials
        rates
      end

      def rates_with_bogus_materials
        rates = RATES.dup
        rates[ :materials ] = 3.14
        rates
      end

      it 'raises an error if there is no flat rate' do
        expect { MarkupCalculator.new( rates_without( :flat ) ) }.to raise_error( RuntimeError )
      end

      it 'raises an error if there is no people rate' do
        expect { MarkupCalculator.new( rates_without( :people ) ) }.to raise_error( RuntimeError )
      end

      it 'raises an error if there is no materials entry' do
        expect { MarkupCalculator.new( rates_without( :materials ) ) }.to raise_error( RuntimeError )
      end

      it 'raises an error if the materials entry is not indexable' do
        expect { MarkupCalculator.new( rates_with_bogus_materials ) }.to raise_error( RuntimeError )
      end

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
          base: 1_299.99,
          people: 3,
          materials: [ :food ],
          output: 1_591.58
        },
        {
          description: 'Example 2: 5432.0, 1 person, drugs (assume pharmaceuticals)',
          base: 5_432.00,
          people: 1,
          materials: [ :pharmaceuticals ],
          output: 6_199.81
        },
        {
          description: 'Example 3: 12456.95, 4 people, books',
          base: 12_456.95,
          people: 4,
          materials: [ :books ],
          output: 13_707.63
        },

        {
          description: 'large amount, multiple people, all known materials, and several new ones',
          base: 1_234_567.89,
          people: 29,
          materials: [ :food, :clothing, :books, :pharmaceuticals, :electronics, :bicycles, :spaceships ],
          output: 2_039_074.06
        }
      ].each do |example|
        it "says #{example[:description]}" do
          expect(
            calculator.calculate( example[ :base ], example[ :people ], example[ :materials ] )
          ).to be_within( 0.005 ).of( example[ :output ] )
        end
      end

    end

  end

end
