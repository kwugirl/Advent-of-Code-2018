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

  def cart_at(location)
    @cart_grid[location]
  end

  private

  def print_map
    puts "=====top of map====="
    (0...@height).each do |y|
      row = []
      (0...@width).each do |x|
        location = "#{x},#{y}"
        cart = cart_at(location)

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
