require 'minitest/autorun'
require_relative '../day_3'

class Day3Test < Minitest::Test
  def test_claim_parsing
    input = "#123 @ 3,2: 5x4"

    claim = Claim.new(input)

    assert_equal "123", claim.id
    assert_equal 3, claim.pos_from_left
    assert_equal 2, claim.pos_from_top
    assert_equal 5, claim.width
    assert_equal 4, claim.height
  end

  def test_occupied_coordinates
    expected = {
      "(4,3)"=>1, "(4,4)"=>1, "(4,5)"=>1, "(4,6)"=>1,
      "(5,3)"=>1, "(5,4)"=>1, "(5,5)"=>1, "(5,6)"=>1,
      "(6,3)"=>1, "(6,4)"=>1, "(6,5)"=>1, "(6,6)"=>1,
      "(7,3)"=>1, "(7,4)"=>1, "(7,5)"=>1, "(7,6)"=>1,
      "(8,3)"=>1, "(8,4)"=>1, "(8,5)"=>1, "(8,6)"=>1
    }

    claim = Claim.new("#123 @ 3,2: 5x4")

    assert_equal expected, claim.occupied_coordinates
  end

  def test_add_claim_to_grid
    claim1 = Claim.new("#123 @ 3,2: 5x4")
    claim2 = Claim.new("#2 @ 3,1: 4x4")
    claim3 = Claim.new("#3 @ 5,5: 2x2")

    grid = Grid.new

    grid.add_claim(claim1)
    grid.add_claim(claim2)
    grid.add_claim(claim3)

    assert_equal [claim1, claim2, claim3], grid.claims
  end
end
