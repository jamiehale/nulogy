module Nulogy
  ##
  # Calculates the markup on a price based on a collection of markups and a
  # set of markup identifiers.
  class MarkupCalculator
    
    def calculate( base_price )
      base_price * 1.05
    end

  end

end
