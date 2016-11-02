module Nulogy
  ##
  # Calculates the markup on a price based on a collection of markups and a
  # set of markup identifiers.
  class MarkupCalculator
   
    FLAT_RATE = 0.05
    PEOPLE_RATE = 0.012

    PHARMACEUTICALS_RATE = 0.075
    FOOD_RATE = 0.13

    def calculate( base_price, people, materials = [] )
      base_price * flat_rate * people_rate( people ) * materials_rate( materials )
    end

    private

    def flat_rate
      multiplier_from( FLAT_RATE )
    end

    def people_rate( people )
      multiplier_from( people * PEOPLE_RATE )
    end

    def pharmaceuticals_rate
      multiplier_from( PHARMACEUTICALS_RATE )
    end

    def food_rate
      multiplier_from( FOOD_RATE )
    end

    def no_materials_markup
      1.00
    end

    def materials_rate( materials )
      return pharmaceuticals_rate if materials.include? :pharmaceuticals
      return food_rate if materials.include? :food
      no_materials_markup
    end

    def multiplier_from( rate )
      1.00 + rate
    end

  end

end
