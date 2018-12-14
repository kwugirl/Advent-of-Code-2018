class Map
  attr_reader :carts

  def initialize(input)
    @grid = {}
    @carts = []

    input.each_with_index do |row, y|
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

  def at(x, y)
    @grid["#{x},#{y}"]
  end

  def track_at(x, y)
    @grid["#{x},#{y}"][:track]
  end

  def cart_at(x, y)
    @grid["#{x},#{y}"][:cart]
  end

  private

  def new_cart(location, direction)
    cart = Cart.new(location, direction)
    @carts << cart
    cart
  end
end

class Cart
  attr_reader :location
  attr_accessor :direction

  def initialize(location, direction)
    @location = location
    @direction = direction
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
    end
  end
end
