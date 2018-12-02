require 'benchmark'

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

  def find_repeated_frequency_alt(changes, starting_point: 0)
    observed_frequencies = { starting_point => true }
    current = starting_point

    while true
      changes.each do |change|
        new_frequency = frequency(current, change)

        if observed_frequencies[new_frequency]
          return new_frequency
        else
          observed_frequencies[new_frequency] = true
          current = new_frequency
        end
      end
    end
  end
end

input = File.readlines('day_1_input.txt').map { |line| line.strip.to_i }
# puts Calibrator.new.total_frequency(input)
# puts Calibrator.new.find_repeated_frequency(input)
puts Calibrator.new.find_repeated_frequency_alt(input)

# Benchmark.bm(25) do |x|
#   x.report("observed_frequencies as array:") do
#     Calibrator.new.find_repeated_frequency(input)
#   end
#   x.report("observed_frequencies as hash:") do
#     Calibrator.new.find_repeated_frequency_alt(input)
#   end
# end

##### Results
#                                 user     system      total        real
# observed_frequencies as array: 56.971103   0.194353  57.165456 ( 57.520675)
# observed_frequencies as hash:  0.032629   0.004284   0.036913 (  0.037067)

