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
