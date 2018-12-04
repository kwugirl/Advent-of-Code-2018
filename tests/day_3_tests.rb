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
end
