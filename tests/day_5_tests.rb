require 'minitest/autorun'
require_relative '../day_5'

class Day5Test < Minitest::Test
  def test_resolve_polarity
    examples = [
      {
        input: "aA",
        expected: ""
      },
      {
        input: "abBA",
        expected: ""
      },
      {
        input: "abAB",
        expected: "abAB"
      },
      {
        input: "aabAAB",
        expected: "aabAAB"
      },
      {
        input: "dabAcCaCBAcCcaDA",
        expected: "dabCBAcaDA"
      }
    ]

    examples.each do |example|
      assert_equal example[:expected], resolve_polarity(example[:input])
    end
  end
end
