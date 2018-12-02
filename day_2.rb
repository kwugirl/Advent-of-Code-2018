def letter_frequencies(word)
  frequencies = Hash.new(0)

  word.chars.each do |letter|
    frequencies[letter] += 1
  end

  frequencies
end

def invert_letter_frequencies(freq)
  inverted_freq = Hash.new { |hash, key| hash[key] = [] }

  freq.each do |letter, count|
    inverted_freq[count] << letter
  end

  inverted_freq
end

def calculate_checksum(ids)
  duos = []
  triplets = []

  ids.each do |id|
    counts = invert_letter_frequencies(letter_frequencies(id))

    duos << id unless counts[2].empty?
    triplets << id unless counts[3].empty?
  end

  duos.count * triplets.count
end

input = File.readlines('inputs/day_2.txt').map { |line| line.strip }
puts calculate_checksum(input)
