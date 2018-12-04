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

  def test_occupied_coordinates_for_claim
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
    claim1 = Claim.new("#1 @ 1,3: 4x4")
    claim2 = Claim.new("#2 @ 3,1: 4x4")
    claim3 = Claim.new("#3 @ 5,5: 2x2")

    grid = Grid.new
    grid.add_claims([claim1, claim2, claim3])

    assert_equal [claim1, claim2, claim3], grid.claims
  end

  def test_occupied_coordinates_on_grid
    claim1 = Claim.new("#1 @ 1,3: 4x4")
    claim2 = Claim.new("#2 @ 3,1: 4x4")
    claim3 = Claim.new("#3 @ 5,5: 2x2")
    grid = Grid.new
    grid.add_claims([claim1, claim2, claim3])

    expected = {
      "(2,4)"=>1, "(2,5)"=>1, "(2,6)"=>1, "(2,7)"=>1,
      "(3,4)"=>1, "(3,5)"=>1, "(3,6)"=>1, "(3,7)"=>1,
      "(4,2)"=>1, "(4,3)"=>1, "(4,4)"=>2, "(4,5)"=>2, "(4,6)"=>1, "(4,7)"=>1,
      "(5,2)"=>1, "(5,3)"=>1, "(5,4)"=>2, "(5,5)"=>2, "(5,6)"=>1, "(5,7)"=>1,
      "(6,2)"=>1, "(6,3)"=>1, "(6,4)"=>1, "(6,5)"=>1, "(6,6)"=>1, "(6,7)"=>1,
      "(7,2)"=>1, "(7,3)"=>1, "(7,4)"=>1, "(7,5)"=>1, "(7,6)"=>1, "(7,7)"=>1
    }

    assert_equal expected, grid.occupied_coordinates
  end

  def test_contested_coordinates_count_on_grid
    claim1 = Claim.new("#1 @ 1,3: 4x4")
    claim2 = Claim.new("#2 @ 3,1: 4x4")
    claim3 = Claim.new("#3 @ 5,5: 2x2")
    grid = Grid.new
    grid.add_claims([claim1, claim2, claim3])

    assert_equal 4, grid.contested_coordinates_count
  end
end
