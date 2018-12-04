class Claim
  attr_reader :id, :pos_from_left, :pos_from_top, :width, :height, :occupied_coordinates

  def initialize(claim)
    parsed = /^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/.match(claim)

    @id = parsed[1]
    @pos_from_left = parsed[2].to_i
    @pos_from_top = parsed[3].to_i
    @width = parsed[4].to_i
    @height = parsed[5].to_i
  end

  def occupied_coordinates
    @occupied_coordinates ||= begin
      coordinates = {}
      starting_x = pos_from_left + 1
      ending_x = pos_from_left + width
      starting_y = pos_from_top + 1
      ending_y = pos_from_top + height

      (starting_x..ending_x).each do |x|
        (starting_y..ending_y).each do |y|
          coordinates["(#{x},#{y})"] = 1
        end
      end
      coordinates
    end
  end
end
