require 'minitest/autorun'
require_relative '../day_1'

class Day1Test < Minitest::Test
  def test_total_frequency
    examples = [
      {
        input: [+1, -2, +3, +1],
        output: 3
      },
      {
        input: [+1, +1, +1],
        output: 3
      },
      {
        input: [+1, +1, -2],
        output: 0
      },
      {
        input: [-1, -2, -3],
        output: -6
      }
    ]

    examples.each do |example|
      assert_equal example[:output], Calibrator.new.total_frequency(example[:input])
    end
  end
end
