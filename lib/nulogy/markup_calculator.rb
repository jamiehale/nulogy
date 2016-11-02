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
      1.00 + FLAT_RATE
    end

    def people_rate( people )
      1.00 + people * PEOPLE_RATE
    end

    def pharmaceuticals_rate
      1.00 + PHARMACEUTICALS_RATE
    end

    def food_rate
      1.00 + FOOD_RATE
    end

    def materials_rate( materials )
      return pharmaceuticals_rate if materials.include? :pharmaceuticals
      return food_rate if materials.include? :food
      1.00
    end

  end

end
