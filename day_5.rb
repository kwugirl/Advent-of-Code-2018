require 'benchmark'

POLAR_PAIRS = begin
  pairs = Hash.new(false)
  ('a'..'z').each do |letter|
    pairs["#{letter}#{letter.upcase}"] = true
    pairs["#{letter.upcase}#{letter}"] = true
  end
  pairs
end

def remove_polar_pairs_original(input)
  output = input.split("")

  output.each_index do |i|
    if polar_pair?(output[i..i+1].join(""))
      output.slice!(i, 2)
    end
  end

  output.join("")
end

def remove_polar_pairs(input)
  output = input.dup

  POLAR_PAIRS.each do |pair, v|
    output.gsub!(pair, '')
  end
  output
end

def polar_pair?(pair)
  POLAR_PAIRS[pair]
end

def resolve_polarity_recursive(polymer)
  reduced_polymer = remove_polar_pairs(polymer)

  if reduced_polymer == polymer
    return reduced_polymer
  else
    resolve_polarity_recursive(reduced_polymer)
  end
end

def resolve_polarity_iterative(polymer)
  reduced_polymers = {
    current: polymer,
    reduced: remove_polar_pairs(polymer)
  }

  while reduced_polymers[:current] != reduced_polymers[:reduced]
    reduced_polymers[:current] = reduced_polymers[:reduced]
    reduced_polymers[:reduced] = remove_polar_pairs(reduced_polymers[:reduced])
  end

  reduced_polymers[:current]
end

def find_optimized_polymer_length(polymer)
  results = {}

  ('a'..'z').each do |letter|
    unit = "#{letter}#{letter.upcase}"
    results[unit] = remove_unit_and_resolve_polarity(polymer, unit)

    unit = "#{letter.upcase}#{letter}"
    results[unit] = remove_unit_and_resolve_polarity(polymer, unit)
  end

  results.min_by { |k,v| v }[1]
end

def remove_unit_and_resolve_polarity(polymer, unit)
  test_polymer = polymer.delete(unit)
  resolve_polarity_iterative(test_polymer).length
end

input = File.read('inputs/day_5.txt').strip
# puts resolve_polarity_iterative(input).length
puts find_optimized_polymer_length(input)

# Benchmark.bm(18) do |x|
#   x.report("recursive approach") do
#     resolve_polarity_recursive(input)
#   end
#   x.report("iterative approach") do
#     resolve_polarity_iterative(input)
#   end
# end
# # RESULTS
#                          user     system      total        real
# recursive approach  16.282709   0.150932  16.433641 ( 16.459125)
# iterative approach  16.017317   0.110487  16.127804 ( 16.141921)

# Benchmark.bm(30) do |x|
#   x.report("remove_polar_pairs_original") do
#     remove_polar_pairs_original(input)
#   end
#   x.report("remove_polar_pairs") do
#     remove_polar_pairs(input)
#   end
# end
# RESULTS
#                                      user     system      total        real
# remove_polar_pairs_original      0.109257   0.002013   0.111270 (  0.111369)
# remove_polar_pairs               0.003737   0.000547   0.004284 (  0.004284)
