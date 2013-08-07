# @author OI
# @date August 6, 2013
# this code excizes the introns from a DNA string
# DNA string and introns are provided in a FASTA format file
require 'yaml'

def gene_to_protein(file_name)
  sequences = read_sequences(file_name)
  seq, introns = sequences[0], sequences[1..-1]
  seq = remove_introns(seq, introns)
  
  translate(seq) # returns protein sequence
end

def read_sequences(file_name)
  file = File.read(file_name)
  file[0] = ""
  records = file.split(">")
  sequences = []
  
  records.each do |record|
    next if record.nil?
    lines = record.split("\n")
    if lines.size > 2
      sequences << lines[1...lines.length].join("")
    else
      sequences << lines[1]
    end
  end
  
  sequences # array of strings. Each string is a DNA seqeunce
end

def remove_introns(seq, introns_array)
  introns_array.each do |intron|
    int_len = intron.length
    i = 0
    while i < seq.length
      if seq[i...(i + int_len)] == intron
        seq = seq[0...i] + seq[(i + int_len)..-1] 
        break
      end
      i += 1
    end
  end
  
  seq
end

# seq = "AAATTTCCCGGG"
# intr = ["TTT", "CG"]
# puts remove_introns(seq, intr)

def translate(dna_seq)
  protein_seq = []
  codons_aa_hash = YAML::load_file "codons_aa.txt" # {codon: [aa, aa_name]}
  codons_array = get_codons(dna_seq)
  codons_array.each do |codon|
    aa = codons_aa_hash[codon][0]
    protein_seq << aa
  end
  
  protein_seq.join("")
end

def get_codons(dna_seq)
  return [] if dna_seq.length < 3
  codons = []
  i = 0
  while i < dna_seq.length - 2
    codons << dna_seq[i..(i + 2)]
    i += 3
  end
  
  codons
end

# s1 = "AAATTT"
# s2 = "ATACGCC"
# puts get_codons(s1)
# puts get_codons(s2)

puts gene_to_protein('test20.txt')








