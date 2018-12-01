class Calibrator
  def total_frequency(changes, starting_point: 0)
    starting_point + changes.sum
  end
end

# input = File.readlines('day_1_input.txt').map { |line| line.strip.to_i }
# puts Calibrator.new.total_frequency(input)
