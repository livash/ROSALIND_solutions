# @author OI
# @date August 8, 2013
# this code finds the the motifs in a DNA string
# given two strings s and t return indeces in s where t is present

def find_motif(seq, motif)
  res = []
  motif_letters = motif.split("")
  seq.split('').each_with_index do |base, idx|
    if seq[idx] == motif_letters.first
      motif_letters.shift
      res << idx + 1
    end
  end
  
  return res if motif_letters.length == 0
  
  []
end

seq = 'ACGTACGTGACG'
motif = 'GTA'

puts find_motif(seq, motif)