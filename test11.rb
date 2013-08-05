# @author OI
# @date August 5, 2013
# this code transcribes ssDNA into corresponding transcribed RNA

def transcribe(dna)
  rna = []
  dna.split("").each do |base|
    if base == "T"
      rna << "U"
    else
      rna << base
    end
  end
  
  rna.join("")
end

test_dna = 'GATGGAACTTGACTACGTAAATT'
puts transcribe(test_dna)