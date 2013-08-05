def two_sum(int_a, int_b)
  i = int_a
  res = 0
  while i <= int_b
    # puts "#{i} => #{res}"
    res += i if i % 2 > 0
    i += 1
  end
  
  res
end

puts two_sum(4368, 9229)