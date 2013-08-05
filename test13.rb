# @author OI
# @date August 5, 2013
# this code read in a file in FASTA format.
# Then calculates 'GC' content of each DNA sequence in the file
# Returns the ID and 'GC' content for a sequence with highest 'GC' content

def highest_GC(file_name)
  seq_hash = make_hash(file_name)
  max_GC = ['name', 0]
  seq_hash.each do |id, seq|
    max_GC = [id, GC_content(seq)] if GC_content(seq) > max_GC[1]
  end
  
  max_GC.join(" ")
end 

def make_hash(file_name)
  res = {}
  file = File.read(file_name)
  id_seq_array = file.split('>')
  puts id_seq_array.count
  id_seq_array.each do |record|
    record_lines = record.split("\n")
    id = record_lines[0]
    seq = (record_lines - [id]).join("")
    res[id] = seq
  end
  
  res
end

def GC_content(seq)
  gc_count = 0
  seq.split('').each do |base|
    gc_count += 1 if base == "G" || base == "C"
  end
  
  gc_count.to_f / seq.length.to_f * 100
end

# test = "CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG"
# puts GC_content(test)

puts highest_GC('test13.txt')