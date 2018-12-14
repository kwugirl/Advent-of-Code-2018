class Map
  attr_reader :carts

  def initialize(input)
    @grid = {}
    @carts = []
    @height = input.length
    @width = 0

    input.each_with_index do |row, y|
      @width = row.length if row.length > @width

      row.each_char.with_index do |char, x|
        location = "#{x},#{y}"

        @grid["#{x},#{y}"] = case char
        when "^"
          {
            track: "|",
            cart: new_cart(location, :up)
          }
        when "v"
          {
            track: "|",
            cart: new_cart(location, :down)
          }
        when "<"
          {
            track: "-",
            cart: new_cart(location, :left)
          }
        when ">"
          {
            track: "-",
            cart: new_cart(location, :right)
          }
        else
          {
            track: char
          }
        end
      end
    end
  end

  def at(location)
    @grid[location]
  end

  def track_at(location)
    @grid[location][:track]
  end

  def cart_at(location)
    @grid[location][:cart]
  end

  private

  # TODO: might not actually need to keep track of carts??
  def new_cart(location, direction)
    cart = Cart.new(location, direction)
    @carts << cart
    cart
  end
end

class Cart
  attr_reader :location
  attr_accessor :direction

  INTERSECTION_OPTIONS = [:left, :straight, :right]

  def initialize(location, direction)
    @location = location
    @direction = direction
    @intersection_count = 0
  end

  def update_location
    x, y = location.split(",").map(&:to_i)

    case direction
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

    case track
    when "/"
      @direction = :up if @direction == :right
      @direction = :left if @direction == :down
      @direction = :down if @direction == :left
      @direction = :right if @direction == :up
    when "\\"
      @direction = :down if @direction == :right
      @direction = :right if @direction == :down
      @direction = :up if @direction == :left
      @direction = :left if @direction == :up
    when "+"
      turn = INTERSECTION_OPTIONS[@intersection_count%3]
      @intersection_count += 1
      @direction = resolve_intersection(turn)
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
