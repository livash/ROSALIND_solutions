# @author OI
# @date Aug 10, 2013
# this code calculates the probability of an offstring
# with dominant allel produced as a result of mating between 
# any two individuals in a population where
# k = number of honozygotes [YY]
# n = number of heterozygotes [Yy]
# m = number of homozygotes [yy]

def probability(k, n, m)
  k = k.to_f
  n = n.to_f
  m = m.to_f
  tot = k + m + n
  
  res_k = k / tot * 1
  res_n = n / tot * (k / (tot - 1) + 3 * ( n - 1) / (4 * (tot - 1)) + 0.5 * m / (tot - 1))
  res_m = m / tot * (k / (tot - 1) + 0.5 * n / (tot - 1))
  
  res_k + res_n + res_m
end

puts probability(26, 24, 22)