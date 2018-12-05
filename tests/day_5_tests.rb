require 'minitest/autorun'
require_relative '../day_5'

class Day5Test < Minitest::Test
  def test_resolve_polarity_recursive
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
      assert_equal example[:expected], resolve_polarity_recursive(example[:input])
    end
  end

  def test_resolve_polarity_iterative
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
      assert_equal example[:expected], resolve_polarity_iterative(example[:input])
    end
  end
end
