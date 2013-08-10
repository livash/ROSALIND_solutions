# @author OI
# @date August 10, 2013
# make directed graph using FASTA formated file of DNA sequences
# sequences have overlap of three base pairs (O3).

def read_file(file_name)
  res_hash = {}
  file = File.read(file_name)
  file[0] = ''
  records = file.split('>')
  
  records.each do |record|
    next if record.nil?
    lines = record.split("\n")
    puts lines.count
    name = lines[0]
    if lines.size > 2
      seq = lines[1...lines.length].join("")
    else
      seq = lines[1]
    end
    res_hash[name] = seq
  end
   
  res_hash # {seq_name: sequence}
end

def make_digraph(seq_hash)
  edges_list = []
  
  seq_hash.each do |name1, seq1|
    if seq1[0..2] == seq1[-3..-1]
      #edges_list << "#{name1} #{name1}"
    end
    seq_hash.each do |name2, seq2|
      if seq1[0..2] == seq2[-3..-1] and name1 != name2
        edges_list << "#{name2} #{name1}"
      elsif seq2[0..2] == seq1[-3..-1] and name1 != name2
        edges_list << "#{name1} #{name2}"
      end
    end
  end
  
  edges_list.uniq # ["seq1 seq2", "seq2 seq3" ]
end

# test 
res_hash = read_file("test23.txt")
puts res_hash
puts make_digraph(res_hash)
