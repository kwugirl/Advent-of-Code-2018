class Map
  attr_reader :carts

  def initialize(input)
    @grid = {}
    @carts = []

    input.each_with_index do |row, y|
      row.each_char.with_index do |char, x|
        location = "#{x}, #{y}"

        @grid["#{x}, #{y}"] = case char
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
    @grid["#{x}, #{y}"]
  end

  def track_at(x, y)
    @grid["#{x}, #{y}"][:track]
  end

  def cart_at(x, y)
    @grid["#{x}, #{y}"][:cart]
  end

  private

  def new_cart(location, direction)
    cart = Cart.new(location, direction)
    @carts << cart
    cart
  end
end

class Cart
  attr_accessor :location, :direction

  def initialize(location, direction)
    @location = location
    @direction = direction
  end
end
