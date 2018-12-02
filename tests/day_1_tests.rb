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

  def test_find_repeated_frequency
    examples = [
      {
        input: [+1, -2, +3, +1],
        output: 2
      },
      {
        input: [+1, -1],
        output: 0
      },
      {
        input: [+3, +3, +4, -2, -4],
        output: 10
      },
      {
        input: [-6, +3, +8, +5, -6],
        output: 5
      },
      {
        input: [+7, +7, -2, -7, -4],
        output: 14
      }
    ]

    examples.each do |example|
      assert_equal example[:output], Calibrator.new.find_repeated_frequency(example[:input])
    end
  end

  def test_find_repeated_frequency_alt
    examples = [
      {
        input: [+1, -2, +3, +1],
        output: 2
      },
      {
        input: [+1, -1],
        output: 0
      },
      {
        input: [+3, +3, +4, -2, -4],
        output: 10
      },
      {
        input: [-6, +3, +8, +5, -6],
        output: 5
      },
      {
        input: [+7, +7, -2, -7, -4],
        output: 14
      }
    ]

    examples.each do |example|
      assert_equal example[:output], Calibrator.new.find_repeated_frequency_alt(example[:input])
    end
  end
end
