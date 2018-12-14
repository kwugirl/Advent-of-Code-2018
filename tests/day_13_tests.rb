require 'minitest/autorun'
require_relative '../day_13'

class MapTest < Minitest::Test
  def setup
    input = [
      "/----\\",
      "^    |",
      "|    v",
      "\\----/"
    ]
    @map = Map.new(input)
  end

  def test_map_track_characters
    assert_equal "/", @map.track_at("0,0")
    assert_equal "\\", @map.track_at("5,0")
    assert_equal "/", @map.track_at("5,3")
  end

  def test_map_track_under_cart
    assert_equal "|", @map.track_at("0,1")
  end

  def test_map_cart
    cart = @map.cart_at("0,1")

    assert_equal :up, cart.direction
    assert_equal "0,1", cart.location
  end

  def test_play
    straight_track = %w(| v | | | ^ |)
    map = Map.new(straight_track)
    assert_equal "0,3", map.play

    second_example = [
      "/->-\\        ",
      "|   |  /----\\",
      "| /-+--+-\\  |",
      "| | |  | v  |",
      "\\-+-/  \\-+--/",
      "  \\------/   "
    ]
    second_map = Map.new(second_example)
    assert_equal "7,3", second_map.play
  end
end

class CartTest < Minitest::Test
  def test_move
    cart = Cart.new("1,1", :left)
    cart.update_location
    assert_equal "0,1", cart.location

    cart = Cart.new("1,1", :up)
    cart.update_location
    assert_equal "1,0", cart.location
  end

  def test_update_direction_straight
    cart = Cart.new("1,1", :left)
    cart.update_direction("-")

    assert_equal :left, cart.direction

    cart = Cart.new("1,1", :up)
    cart.update_direction("|")

    assert_equal :up, cart.direction
  end

  def test_update_direction_curve
    cart = Cart.new("1,1", :left)
    cart.update_direction("/")

    assert_equal :down, cart.direction

    cart = Cart.new("1,1", :right)
    cart.update_direction("\\")

    assert_equal :down, cart.direction
  end

  def test_update_direction_bad_input
    cart = Cart.new("1,1", :left)

    assert_raises StandardError do
      cart.update_direction("|")
    end
  end

  def test_update_direction_intersections
    cart = Cart.new("1,1", :left)

    cart.update_direction("+")
    assert_equal :down, cart.direction

    cart.update_direction("+")
    assert_equal :down, cart.direction

    cart.update_direction("+")
    assert_equal :left, cart.direction

    cart.update_direction("+")
    assert_equal :down, cart.direction
  end
end
