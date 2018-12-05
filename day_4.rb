require 'time'

class Record
  def self.fill_in_guard(records)
    updated_records = []
    current_guard = records.first.split(" ")[3]

    records.each do |record|
      pieces = record.split(" ")

      if pieces[2] == "Guard"
        current_guard = pieces[3]
      else
        new_record = pieces.insert(2, current_guard).join(" ")
        updated_records << new_record
      end
    end

    updated_records
  end

  def self.parse(records)
    guards = {}

    records.each_slice(2) do |asleep, awake|
      start_time = Record.parse_time(asleep)
      end_time = Record.parse_time(awake)
      sleep_log = SleepLog.new(start_time, end_time)

      guard_id = Record.parse_guard_id(asleep)

      if guards[guard_id]
        guards[guard_id].add_sleep(sleep_log)
      else
        guards[guard_id] = Guard.new(guard_id, sleep_log)
      end
    end

    guards
  end

  def self.parse_time(record)
    pieces = record.split(" ")
    Time.parse(pieces[0..1].join(" ")[1..-2])
  end

  def self.parse_guard_id(record)
    record.split(" ")[2].delete("#")
  end
end

class Guard
  attr_reader :id
  attr_accessor :sleep_logs

  def initialize(id, sleep_logs=[])
    @id = id
    @sleep_logs = Array(sleep_logs)
  end

  def add_sleep(sleep_log)
    @sleep_logs << sleep_log
  end

  def total_sleep
    sleep_logs.inject(0) { |sum, log| sum += log.length_in_minutes }
  end

  def sleepier_than(other_guard)
    total_sleep > other_guard.total_sleep
  end

  def sleepiest_minute
    sleeping_minute_frequencies.max_by{ |k,v| v }[0]
  end

  def sleepiest_minute_count
    sleeping_minute_frequencies.max_by{ |k,v| v }[1]
  end

  def sleeping_minute_frequencies
    midnight_hour = Hash.new(0)

    sleep_logs.each do |log|
      log.minutes_asleep.each { |min| midnight_hour[min] += 1 }
    end

    midnight_hour
  end
end

class SleepLog
  attr_reader :start_time, :end_time

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
  end

  def length_in_seconds
    end_time - start_time
  end

  def length_in_minutes
    length_in_seconds/60
  end

  def minutes_asleep
    starting_min = start_time.min
    ending_min = end_time.min
    minutes_asleep = []

    (starting_min...ending_min).each do |min|
      minutes_asleep << min
    end

    minutes_asleep
  end
end

class Analysis
  attr_reader :guards

  def initialize(guards)
    @guards = guards
  end

  def sleepiest_guard
    sleepiest_guard = guards[guards.keys.sample]

    guards.each do |guard_id, guard|
      sleepiest_guard = guard if guard.sleepier_than(sleepiest_guard)
    end

    sleepiest_guard
  end

  def sleepiest_guard_sleepiest_minute
    guard = sleepiest_guard
    sleepiest_minute = guard.sleepiest_minute

    guard.id.to_i * sleepiest_minute
  end

  def most_frequently_asleep_guard
    most_frequently_asleep_guard = guards[guards.keys.sample]

    guards.each do |guard_id, guard|
      if guard.sleepiest_minute_count > most_frequently_asleep_guard.sleepiest_minute_count
        most_frequently_asleep_guard = guard
      end
    end

    most_frequently_asleep_guard
  end

  def most_frequently_asleep_minute
    guard = most_frequently_asleep_guard
    sleepiest_minute = guard.sleepiest_minute

    guard.id.to_i * sleepiest_minute
  end
end

raw_records = File.readlines('inputs/day_4.txt').map { |line| line.strip }.sort
records_with_guards = Record.fill_in_guard(raw_records)
guards = Record.parse(records_with_guards)
# puts Analysis.new(guards).sleepiest_guard_sleepiest_minute
puts Analysis.new(guards).most_frequently_asleep_minute
