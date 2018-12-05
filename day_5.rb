def remove_polar_pairs(input)
  output = input.split("")

  output.each_index do |i|
    if polar_pair?(output[i..i+1])
      output.slice!(i, 2)
    end
  end

  output.join("")
end

def polar_pair?(pair)
  return false unless pair[1]

  first_letter = pair[0]
  second_letter = pair[1]

  first_letter == second_letter.swapcase
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
