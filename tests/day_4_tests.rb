require 'minitest/autorun'
require_relative '../day_4'

EXAMPLE_RECORDS = [
  "[1518-11-01 00:00] Guard #10 begins shift",
  "[1518-11-01 00:05] falls asleep",
  "[1518-11-01 00:25] wakes up",
  "[1518-11-01 00:30] falls asleep",
  "[1518-11-01 00:55] wakes up",
  "[1518-11-01 23:58] Guard #99 begins shift",
  "[1518-11-02 00:40] falls asleep",
  "[1518-11-02 00:50] wakes up",
  "[1518-11-03 00:05] Guard #10 begins shift",
  "[1518-11-03 00:24] falls asleep",
  "[1518-11-03 00:29] wakes up",
  "[1518-11-04 00:02] Guard #99 begins shift",
  "[1518-11-04 00:36] falls asleep",
  "[1518-11-04 00:46] wakes up",
  "[1518-11-05 00:03] Guard #99 begins shift",
  "[1518-11-05 00:45] falls asleep",
  "[1518-11-05 00:55] wakes up"
]

class Day4Test < Minitest::Test
  def test_fill_in_guard
    expected = [
      "[1518-11-01 00:05] #10 falls asleep",
      "[1518-11-01 00:25] #10 wakes up",
      "[1518-11-01 00:30] #10 falls asleep",
      "[1518-11-01 00:55] #10 wakes up",
      "[1518-11-02 00:40] #99 falls asleep",
      "[1518-11-02 00:50] #99 wakes up",
      "[1518-11-03 00:24] #10 falls asleep",
      "[1518-11-03 00:29] #10 wakes up",
      "[1518-11-04 00:36] #99 falls asleep",
      "[1518-11-04 00:46] #99 wakes up",
      "[1518-11-05 00:45] #99 falls asleep",
      "[1518-11-05 00:55] #99 wakes up"
    ]

    assert_equal expected, Record.fill_in_guard(EXAMPLE_RECORDS)
  end

end
