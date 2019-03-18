def substring(word, dict)
  hash = Hash.new(0)
  while dict.size != 0 do
    temp = dict.pop
    t = word.scan(temp).size
    if t > 0
      hash[temp] = t
    end
  end
  hash = hash.to_a.reverse.to_h
  return hash
end

puts "Enter word:"
word = gets.chomp.downcase
puts "Enter dictionary words, seperated by space"
dict = gets.chomp.downcase.split
p substring(word,dict)
