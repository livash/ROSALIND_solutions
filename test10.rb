# @author OI
# @date August 5, 2013
# this code calculates the count for each DNA base in a given sequences
def read_sequence(seq)
  res_hash = {'A' => 0, 'C'=> 0, 'G'=> 0, 'T'=> 0}
  letters = seq.split("")
  letters.each do |letter|
    res_hash[letter] += 1
  end
  
  [res_hash['A'], res_hash['C'], res_hash['G'], res_hash['T']].join(" ")
end

seq = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'

puts read_sequence(seq)