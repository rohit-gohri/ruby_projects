def stock_picker(stock_prices)
  pair = []
  pairs = stock_prices.combination(2).to_a.delete_if { |pair| pair[0] > pair[1]}
  if (pairs.size < 2)
    return 0
  end
  pair = pairs.max {|a,b| a[1]-a[0] <=> b[1]-b[0]}
  pair = [stock_prices.find_index(pair[0]),stock_prices.find_index(pair[1])]
  return pair
end

puts "Enter array of stock prices, seperated by comma"
input_arr = []
gets.chomp.split(",").each {|chr| input_arr.push(chr.to_i)}
p stock_picker(input_arr)
