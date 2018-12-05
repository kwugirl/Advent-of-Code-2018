POLAR_PAIRS = begin
  pairs = Hash.new(false)
  ('a'..'z').each do |letter|
    pairs["#{letter}#{letter.upcase}"] = true
    pairs["#{letter.upcase}#{letter}"] = true
  end
  pairs
end

def remove_polar_pairs(input)
  output = input.split("")

  output.each_index do |i|
    if polar_pair?(output[i..i+1].join(""))
      output.slice!(i, 2)
    end
  end

  output.join("")
end

def polar_pair?(pair)
  POLAR_PAIRS[pair]
end

def resolve_polarity(polymer)
  reduced_polymer = remove_polar_pairs(polymer)

  if reduced_polymer == polymer
    return reduced_polymer
  else
    resolve_polarity(reduced_polymer)
  end
end

input = File.read('inputs/day_5.txt').strip
puts resolve_polarity(input).length
