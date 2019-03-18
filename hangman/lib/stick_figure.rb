def draw(chances)
  c = 9 - chances
  puts '___' if c > 0
  puts " |" if c > 1
  puts "(_)" if c > 2
  print '/' if c > 3
  print '|' if c > 4
  puts "\\" if c > 5
  puts ' |' if c > 6
  print '/' if c > 7
  puts " \\" if c > 8
end
