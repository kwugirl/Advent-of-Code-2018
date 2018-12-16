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

  def test_find_first_crash
    straight_track = %w(| v | | | ^ |)
    map = Map.new(straight_track)
    assert_equal "0,3", map.find_first_crash

    second_example = [
      "/->-\\        ",
      "|   |  /----\\",
      "| /-+--+-\\  |",
      "| | |  | v  |",
      "\\-+-/  \\-+--/",
      "  \\------/   "
    ]
    second_map = Map.new(second_example)
    assert_equal "7,3", second_map.find_first_crash
  end

  def test_find_first_crash_idempotent
    straight_track = %w(| v | | | ^ |)
    map = Map.new(straight_track)
    map.find_first_crash

    assert_equal :down, map.cart_at("0,1").direction
    assert_equal "0,1", map.cart_at("0,1").location
    assert_equal :up, map.cart_at("0,5").direction
  end

  def test_find_rightward_crash
    input = [">--<"]
    map = Map.new(input)

    assert_equal "2,0", map.find_first_crash
  end

  def test_find_leftward_crash
    input = [">-<"]
    map = Map.new(input)

    assert_equal "1,0", map.find_first_crash
  end

  def test_find_upward_crash
    input = %w(v | ^)
    map = Map.new(input)

    assert_equal "0,1", map.find_first_crash
  end

  def test_find_downward_crash
    input = %w(v ^)
    map = Map.new(input)

    assert_equal "0,1", map.find_first_crash
  end

  def test_find_last_cart_standing
    example = [
      "/>-<\\  ",
      "|   |  ",
      "| /<+-\\",
      "| | | v",
      "\\>+</ |",
      "  |   ^",
      "  \\<->/"
    ]
    map = Map.new(example)

    assert_equal "6,4", map.find_last_cart_standing
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
