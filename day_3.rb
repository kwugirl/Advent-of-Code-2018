class Claim
  attr_reader :id, :pos_from_left, :pos_from_top, :width, :height

  def initialize(claim)
    parsed = /^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/.match(claim)

    @id = parsed[1]
    @pos_from_left = parsed[2].to_i
    @pos_from_top = parsed[3].to_i
    @width = parsed[4].to_i
    @height = parsed[5].to_i
  end
end
