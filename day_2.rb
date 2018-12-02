def letter_frequencies(word)
  frequencies = Hash.new(0)

  word.chars.each do |letter|
    frequencies[letter] += 1
  end

  frequencies
end
