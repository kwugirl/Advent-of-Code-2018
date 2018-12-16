require 'pry'

class Map
  attr_reader :cart_grid

  def initialize(input)
    @track_grid = {}
    @cart_grid = CartGrid.new
    @height = input.length
    @width = 0

    input.each_with_index do |row, y|
      @width = row.length if row.length > @width

      row.each_char.with_index do |char, x|
        location = "#{x},#{y}"

        case char
        when "^", "v", "<", ">"
          conversion = Cart::CHAR_UNMAPPING[char]

          @track_grid[location] = conversion[:track]
          @cart_grid.add_cart(Cart.new(location, conversion[:direction]))
        else
          @track_grid[location] = char
        end
      end
    end
  end

  def track_at(location)
    @track_grid[location]
  end

  def cart_at(location)
    @cart_grid.at(location)
  end

  def play_tick
    new_cart_grid = CartGrid.new
    crashed_cart_locations = []

    # could probably find a way to sort the carts to not have to
    # loop over all coordinates in order like this
    (0...@height).each do |y|
      (0...@width).each do |x|
        location = "#{x},#{y}"
        cart = @cart_grid.at(location)

        if cart
          @cart_grid.remove_cart_at(location)
          new_location = cart.update_location

          if new_cart_grid.at(new_location)
            puts "Crash! at #{new_location} (on new map)"
            crashed_cart_locations << new_location
            new_cart_grid.remove_cart_at(new_location)
          elsif @cart_grid.at(new_location)
            puts "Crash! at #{new_location} (on old map)"
            crashed_cart_locations << new_location
            @cart_grid.remove_cart_at(new_location)
          else
            cart.update_direction(track_at(new_location))
            new_cart_grid.add_cart(cart)
          end
        end
      end
    end

    [crashed_cart_locations, new_cart_grid]
  end

  def find_first_crash
    original_cart_grid = CartGrid.new(@cart_grid.carts)
    crashed_cart_locations = []

    while crashed_cart_locations.length == 0
      crashed_cart_locations, @cart_grid = play_tick
    end

    # reset so that this method is idempotent
    @cart_grid = original_cart_grid

    crashed_cart_locations.first
  end

  private

  def print_map(carts = @cart_grid)
    puts "=====top of map====="
    (0...@height).each do |y|
      row = []
      (0...@width).each do |x|
        location = "#{x},#{y}"
        cart = carts.at(location)

        if cart
          row << cart.to_s
        else
          row << track_at(location)
        end
      end
      puts row.join("")
    end
    puts "=====bottom of map====="
  end
end

class CartGrid
  attr_reader :carts

  def initialize(carts = {})
    @carts = Hash[carts.map { |location, cart| [location, cart.dup] }]
  end

  def at(location)
    @carts[location]
  end

  def remove_cart_at(location)
    @carts.delete(location)
  end

  def add_cart(cart)
    @carts[cart.location] = cart
  end
end

class Cart
  attr_reader :location, :direction

  CHAR_UNMAPPING = {
    "^" => { track: "|", direction: :up},
    "v" => { track: "|", direction: :down},
    ">" => { track: "-", direction: :right},
    "<" => { track: "-", direction: :left}
  }
  CHAR_MAPPING = {
    up: "^",
    down: "v",
    right: ">",
    left: "<"
  }
  INTERSECTION_OPTIONS = [:left, :straight, :right]

  def initialize(location, direction)
    @location = location
    @direction = direction
    @intersection_count = 0
  end

  def to_s
    CHAR_MAPPING[@direction]
  end

  def update_location
    x, y = location.split(",").map(&:to_i)

    case @direction
    when :up
      y -= 1
    when :down
      y += 1
    when :left
      x -= 1
    when :right
      x += 1
    end

    @location = "#{x},#{y}"
  end

  def update_direction(track)
    if track == "-" && (@direction == :up || @direction == :down) ||
      track == "|" && (@direction == :left || @direction == :right)
      raise "This doesn't seem valid: #{self}, #{track}"
    end

    @direction = case track
    when "/"
      if @direction == :right
        :up
      elsif @direction == :down
        :left
      elsif @direction == :left
        :down
      elsif @direction == :up
        :right
      end
    when "\\"
      if @direction == :right
        :down
      elsif @direction == :down
        :right
      elsif @direction == :left
        :up
      elsif @direction == :up
        :left
      end
    when "+"
      turn = INTERSECTION_OPTIONS[@intersection_count%3]
      @intersection_count += 1
      resolve_intersection(turn)
    else
      @direction
    end
  end

  private

  def resolve_intersection(turn)
    case turn
    when :left
      return :up if @direction == :right
      return :right if @direction == :down
      return :down if @direction == :left
      return :left if @direction == :up
    when :straight
      return @direction
    when :right
      return :down if @direction == :right
      return :left if @direction == :down
      return :up if @direction == :left
      return :right if @direction == :up
    end
  end
end

# input = File.readlines('inputs/day_13.txt').map { |line| line.chomp }
# map = Map.new(input)
# puts "First crash happened at #{map.find_first_crash}"
