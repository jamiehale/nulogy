module Nulogy

  ##
  # Calculates the markup on a price based on a collection of markups and a
  # set of markup identifiers.
  class MarkupCalculator

    def initialize( rates )
      @rates = rates
      validate_rates
    end

    def calculate( base_price, people, materials )
      validate_base_price( base_price )
      validate_people( people )
      base_price * flat_rate * extra_rate( people, materials )
    end

    private

    def validate_rates
      raise 'No flat rate defined' unless @rates.key? :flat
      raise 'No people rate defined' unless @rates.key? :people
      raise 'No materials defined' unless @rates.key? :materials
      raise 'Materials are not indexable' unless @rates[ :materials ].respond_to?( :[] )
    end

    def validate_base_price( base_price )
      raise 'Invalid base price parameter' if base_price < 0.00
    end

    def validate_people( people )
      raise 'Invalid people parameter' if people < 0
    end

    def flat_rate
      multiplier_from( @rates[ :flat ] )
    end

    def people_rate( people )
      people * @rates[ :people ]
    end

    def extra_rate( people, materials )
      multiplier_from( people_rate( people ) + materials_rate( materials ) )
    end

    def material_rate( material )
      return @rates[ :materials ][ material ] if @rates[ :materials ].key? material
      0.00
    end

    def materials_rate( materials )
      materials.inject( 0.00 ) { |a, e| a + material_rate( e ) }
    end

    def multiplier_from( rate )
      1.00 + rate
    end

  end

end
