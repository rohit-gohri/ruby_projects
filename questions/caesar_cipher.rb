def caesar_cipher(text,shift_factor)
  ans = ""
  text.each_char { |char| ans += cipher(char, shift_factor)}
  return ans
end

def cipher(char, factor)
  asc = char.ord
  if((65..90).include?(asc))
    asc += factor
    if (!(65..90).include?(asc))
      asc = (asc-91) + 65
    end
  elsif ((97..122).include?(asc))
    asc += factor
    if (!(97..122).include?(asc))
      asc = (asc-123) + 97
    end
  end
  char = asc.chr
  return char
end

puts "Enter text:"
text = gets.chomp
puts "Enter shift factor:"
factor = gets.chomp.to_i
puts caesar_cipher(text, factor)
