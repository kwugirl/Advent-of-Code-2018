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

  def test_guard_sleep_total
    input = [
      "[1518-11-01 00:05] #10 falls asleep",
      "[1518-11-01 00:25] #10 wakes up",
      "[1518-11-01 00:30] #10 falls asleep",
      "[1518-11-01 00:55] #10 wakes up"
    ]
    parsed_records = Record.parse(input)

    assert_equal 45, parsed_records["10"].total_sleep
  end

  def test_find_sleepiest_guard
    input = [
      "[1518-11-01 00:05] #10 falls asleep",
      "[1518-11-01 00:25] #10 wakes up",
      "[1518-11-01 00:30] #1 falls asleep",
      "[1518-11-01 00:55] #1 wakes up"
    ]
    guards = Record.parse(input)
    analysis = Analysis.new(guards)

    assert_equal "1", analysis.sleepiest_guard.id
  end

  def test_minutes_asleep
    time1 = Time.new(2002, 10, 31, 0, 2)
    time2 = Time.new(2002, 10, 31, 0, 4)
    sleep = SleepLog.new(time1, time2)

    assert_equal [2, 3], sleep.minutes_asleep
  end

  def test_guard_sleepiest_minute
    time1 = Time.new(2002, 10, 31, 0, 2)
    time2 = Time.new(2002, 10, 31, 0, 3)
    time3 = Time.new(2002, 10, 31, 0, 4)
    first_sleep = SleepLog.new(time1, time3)
    second_sleep = SleepLog.new(time2, time3)
    guard = Guard.new("test", [first_sleep, second_sleep])

    assert_equal 3, guard.sleepiest_minute
  end

  def test_find_most_frequently_asleep_guard
    records_with_guards = Record.fill_in_guard(EXAMPLE_RECORDS)
    guards = Record.parse(records_with_guards)
    analysis = Analysis.new(guards)

    assert_equal "99", analysis.most_frequently_asleep_guard.id
  end
end
