module Nulogy
  ##
  # Calculates the markup on a price based on a collection of markups and a
  # set of markup identifiers.
  class MarkupCalculator
  
    def initialize( rates )
      @rates = rates
    end

    def calculate( base_price, people, materials )
      base_price * flat_rate * people_rate( people ) * materials_rate( materials )
    end

    private

    def flat_rate
      multiplier_from( @rates[ :flat ] )
    end

    def people_rate( people )
      multiplier_from( people * @rates[ :people ] )
    end

    def no_materials_markup
      1.00
    end

    def materials_rate( materials )
      rate = no_materials_markup
      materials.each do |material|
        rate += @rates[ :materials ][ material ] if @rates[ :materials ].has_key? material
      end
      rate
    end

    def multiplier_from( rate )
      1.00 + rate
    end

  end

end
