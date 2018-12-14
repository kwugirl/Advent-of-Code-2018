class Map
  def initialize(input)
    @track_grid = {}
    @cart_grid = {}
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
          @cart_grid[location] = Cart.new(location, conversion[:direction])
        else
          @track_grid[location] = char
        end
      end
    end
  end

  def track_at(location)
    @track_grid[location]
  end

  def cart_at(location, map = @cart_grid)
    map[location]
  end

  def play
    # print_map
    while true
      @new_cart_grid = @cart_grid.dup

      (0...@height).each do |y|
        (0...@width).each do |x|
          location = "#{x},#{y}"
          cart = cart_at(location)

          if cart
            remove_cart(location)
            cart.update_location

            if cart_at(cart.location, @new_cart_grid)
              puts "Crash! at #{cart.location}"
              return cart.location
            else
              cart.update_direction(track_at(cart.location))
              add_cart(cart)
              # print_map(@new_cart_grid)
            end
          end
        end
      end

      @cart_grid = @new_cart_grid
    end
  end

  private

  def remove_cart(location)
    @new_cart_grid.delete(location)
  end

  def add_cart(cart)
    @new_cart_grid[cart.location] = cart
  end

  def print_map(map = @cart_grid)
    puts "=====top of map====="
    (0...@height).each do |y|
      row = []
      (0...@width).each do |x|
        location = "#{x},#{y}"
        cart = cart_at(location, map)

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
