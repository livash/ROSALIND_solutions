# @author OI
# @date Aug 10, 2013
# Mortal Fibonacci rabits
# assume starting with one pari of rabits
# n = number of observation months
# m = number of months a rabit lives
# return a number of rabit pairs after (n, m)

def mortal_fibs(n, m)

  rabbits=Array.new(m, 0)
  rabbits[0] = 1
  n.times do
    i = m
    pairs = 0
    while i > 0
      rabbits[i] = rabbits[i-1]
      if i >= 2
      pairs += rabbits[i]
    end
      i -= 1
    end
    rabbits[0] = pairs
    total_rabbits = 0
    rabbits.each do |num|
      total_rabbits += num
    end
    total_rabbits -= rabbits.last
    p rabbits
  
    puts "#{total_rabbits} total rabbits"
    puts "#{pairs} new rabbits were born, yay"
  end
end

puts mortal_fibs(6, 3)


# Using a OOP was not wise in this case,
# calculations were too slow O(n^2)
class Rabbit_pair
  #LIFE_LENGTH = 3
  
  def initialize
    @months = 0
    @children_produced = 0
  end
  

  
  def age
    @months += 1
    # puts "months #{@months}"
  end
  
  def breed
    if can_breed?
      return Rabbit_pair.new
    else
      return nil
    end
  end

  
  def can_breed?
     @months > 1 and @months <= 3
  end
  
  def is_alive?
    @months < 3
  end
  def months
    @months
  end
end

def mortal_fibs(n, m)
  rabbits = [Rabbit_pair.new]
  counter = 1
 while counter < n
   p counter
   p rabbits.size
    counter +=1
    # puts "months ===== #{counter}"
     # p "pairs to date", rabbits.length
    rabbits.each do  |pair|
       pair.age  
    end
    new_rabbits=[]
    rabbits.each do |pair|
      next if pair.nil?
      rabbits << pair.breed
      new_rabbits << pair if pair and pair.is_alive?
    end
     rabbits=new_rabbits
   
  end
  
  alive_rabbit_pairs = 0
  rabbits.each do |pair|
    # p "paired months #{pair.months} children produced #{pair.children_produced}"
    alive_rabbit_pairs += 1 if pair.is_alive?
  end
  
  alive_rabbit_pairs
end

#puts mortal_fibs(100, 17)



# def mortal_fibs(n, m)
#   months = 1
#   children = [1]
#   parents = [0]
#   
#   while months <= n
#     months += 1
#     puts "months: #{months}"
#     
#     if parents.length == m
#       dead = parents.shift
#       puts "Dead rabbits #{dead}"
#     end
#     new_parents = children.pop
#     children << parents.inject(:+)
#     parents << new_parents
#     
#     puts "children: #{children.inject(:+)}"
#     puts "parents: #{parents}"
#     
#   end
#   
#   
#   parents.inject(:+) + children.inject(:+)
# end
# 
# puts mortal_fibs(6, 3)