# @author OI
# @date August 5, 2013
# this is a code for Fibonacci sequence
# where n = number of months (n <= 40)
# and k = number of reproducing rabbit pairs produced by one pair 
# k<= 5
# number of rabbits pairs in n months = (k + 1) * k ** (n - 1)

def fibs(n, k)
  months = 2
  children = 0
  parents = 1
  while months < n
    months += 1
    prev_children = children
    children = parents * k
    parents += prev_children
    puts "months = #{months} ... parents = #{parents} .... children = #{children}"
  end
  
  children + parents
end

puts fibs(34, 4)