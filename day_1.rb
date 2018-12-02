class Calibrator
  def total_frequency(changes, starting_point: 0)
    starting_point + changes.sum
  end

  def frequency(current, change)
    current + change
  end

  def find_repeated_frequency(changes, starting_point: 0)
    observed_frequencies = [starting_point]

    while true
      changes.each do |change|
        new_frequency = frequency(observed_frequencies.last, change)

        if observed_frequencies.include?(new_frequency)
          return new_frequency
        else
          observed_frequencies << new_frequency
        end
      end
    end
  end
end

# input = File.readlines('day_1_input.txt').map { |line| line.strip.to_i }
# puts Calibrator.new.total_frequency(input)
# puts Calibrator.new.find_repeated_frequency(input)
