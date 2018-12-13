class Map
  def initialize(input)
    @grid = {}

    input.each_with_index do |row, y|
      row.each_char.with_index do |char, x|
        case char
        when "^", "v"
          char = "|"
        when "<", ">"
          char = "-"
        end

        @grid["#{x}, #{y}"] = char
      end
    end
  end

  def location(x, y)
    @grid["#{x}, #{y}"]
  end
end
