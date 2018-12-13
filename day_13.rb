class TrackMap
  def initialize(input)
    @map = {}

    input.each_with_index do |row, y|
      row.each_char.with_index do |char, x|
        @map["#{x}, #{y}"] = char
      end
    end
  end

  def location(x, y)
    @map["#{x}, #{y}"]
  end
end
