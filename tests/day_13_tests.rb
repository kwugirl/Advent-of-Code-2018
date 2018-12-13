require 'minitest/autorun'
require_relative '../day_13'

class Day13Test < Minitest::Test
  def test_track_map
    input = [
      "/----\\",
      "|    |",
      "|    |",
      "\\----/"
    ]
    map = TrackMap.new(input)

    assert_equal "/", map.location(0,0)
    assert_equal "\\", map.location(5,0)
    assert_equal "/", map.location(5,3)
  end
end
