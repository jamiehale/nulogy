# Nulogy

This is the result of a coding challenge for Nulogy.

The gem includes a single class, MarkupCalculator, that calculates markups on a price given parameters including number of people assigned to the job and the materials involved. Rates are passed in a Hash to constructor.

The rates hash must include :flat, :people, and :materials (a sub-hash of materials mapped to rates).

(The challenge instructions (coding_exercise.txt) are included in the root of the repo for anyone other than Nulogy looking...)

Ruby 2.3 recommended, though it passes all tests in 2.2.

## Installation (Optional)

NOTE: Installation is not required for testing.

After cloning the repo, run:

    $ bundle install
    $ rake build
    $ gem install pkg/nulogy-0.1.0.gem

## Testing

After cloning the repo, run:

    $ bundle rspec
