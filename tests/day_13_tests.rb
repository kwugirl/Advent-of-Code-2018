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
    assert_equal "/", @map.track_at(0,0)
    assert_equal "\\", @map.track_at(5,0)
    assert_equal "/", @map.track_at(5,3)
  end

  def test_map_track_under_cart
    assert_equal "|", @map.track_at(0,1)
  end

  def test_map_cart
    cart = @map.cart_at(0,1)

    assert_equal :up, cart.direction
    assert_equal "0, 1", cart.location
  end
end
