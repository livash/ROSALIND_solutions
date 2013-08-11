# @author OI
# @date Aug, 11, 2013
# this code calculates the number of possible RNA seqeunces
# for a specific portein sequence
# return resulting number as mod 1,000,000

require 'yaml'

def number_of_rna_seq(prot_seq)
  num_array = [] # array of numbers representing the number of codons for each aa in a prot_seq
  aa_codon_counts_hash = codons_count_hash('codons_aa.txt')
  prot_seq.split('').each do |aa|
    num_array << aa_codon_counts_hash[aa]
  end
  
  res = num_array.inject(:*) * 3 # last multiplication for stop codons
  res % 1000000
end

def codons_count_hash(file_name)
  res = {} # {aa: num_of_codons}
  codons_to_aa_hash = YAML::load_file file_name
  
  codons_to_aa_hash.each do |codon, aa|
    res[aa[0]] ||= 0
    res[aa[0]] += 1
  end
  
  res
end
seq = 'MAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMAMA' * 20
puts seq.length

puts number_of_rna_seq(seq)