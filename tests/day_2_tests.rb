require 'minitest/autorun'
require_relative '../day_2'

class Day2Test < Minitest::Test
  def test_letter_frequencies
    examples = [
      {
        input: "abcdef",
        output: { "a" => 1, "b" => 1, "c" => 1, "d" => 1, "e" => 1, "f" => 1 }
      },
      {
        input: "bababc",
        output: { "a" => 2, "b" => 3, "c" => 1 }
      }
    ]

    examples.each do |example|
      assert_equal example[:output], letter_frequencies(example[:input])
    end
  end

  def test_invert_letter_frequencies
    examples = [
      {
        input: { "a" => 1, "b" => 1, "c" => 1, "d" => 1, "e" => 1, "f" => 1 },
        output: { 1 => ["a", "b", "c", "d", "e", "f"] }
      },
      {
        input: { "a" => 2, "b" => 3, "c" => 1 },
        output: { 1 => ["c"], 2 => ["a"], 3 => ["b"] }
      }
    ]

    examples.each do |example|
      assert_equal example[:output], invert_letter_frequencies(example[:input])
    end
  end

  def test_calculate_checksum
    input = %w(abcdef bababc abbcde abcccd aabcdd abcdee ababab)

    assert_equal 12, calculate_checksum(input)
  end

  def test_find_correct_box_id
    input = %w(abcde fghij klmno pqrst fguij axcye wvxyz)

    assert_equal "fgij", find_correct_box_id(input)
  end
end
