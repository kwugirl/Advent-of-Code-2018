require 'minitest/autorun'
require_relative '../day_13'

class Day13Test < Minitest::Test
  def setup
    input = [
      "/----\\",
      "^    |",
      "|    |",
      "\\----/"
    ]
    @map = Map.new(input)
  end

  def test_map_track_characters
    assert_equal "/", @map.location(0,0)
    assert_equal "\\", @map.location(5,0)
    assert_equal "/", @map.location(5,3)
  end

  def test_map_track_under_cart
    assert_equal "|", @map.location(0,1)
  end
end
