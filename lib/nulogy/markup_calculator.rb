module Nulogy
  ##
  # Calculates the markup on a price based on a collection of markups and a
  # set of markup identifiers.
  class MarkupCalculator
    
    def calculate( base_price, people = 0 )
      base_price * 1.05 * ( 1.00 + people * 0.012 )
    end

  end

end
