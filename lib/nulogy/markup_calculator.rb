module Nulogy
  ##
  # Calculates the markup on a price based on a collection of markups and a
  # set of markup identifiers.
  class MarkupCalculator
   
    FLAT_RATE = 0.05
    PEOPLE_RATE = 0.012

    def calculate( base_price, people )
      base_price * ( 1.00 + FLAT_RATE ) * ( 1.00 + people * PEOPLE_RATE )
    end

  end

end
