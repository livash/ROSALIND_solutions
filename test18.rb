# @author OI
# @date August 5, 2013
#read in a FASTA format file with less than 10 sequences
# return a consensus string for these sequences and a profile matrix
require 'debugger'

def consensus_profile(file_name)
  sequences = read_sequences(file_name)
  profile = prof_matrix(sequences)
  consensus = cons_seq(profile)
  
  [consensus, profile]
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
  
  sequences
end

def prof_matrix(sequences)
  n = sequences.first.length
  res = {'A' => Array.new(n, 0), 'T' => Array.new(n, 0), 'G' => Array.new(n, 0), 'C' => Array.new(n, 0)}

  sequences.each do |sequence|
    sequence.split('').each_with_index do |base, i|
      
      res[base][i] += 1 if res[base][i]
    
    end
  end
  
  res
end

def cons_seq(profile_hash)
  res_sequence = []
  i = 0
  while i < profile_hash['A'].length
    #debugger
    max = profile_hash['A'][i]
    res_sequence[i] = 'A'
    if max < profile_hash['T'][i]
      max = profile_hash['T'][i]
      res_sequence[i] = 'T'
    end
    if max < profile_hash['C'][i]
      max = profile_hash['C'][i]
      res_sequence[i] = 'C'
    end
    if max < profile_hash['G'][i]
      max = profile_hash['G'][i]
      res_sequence[i] = 'G'
    end
    i += 1
  end
  
  res_sequence.join('')
end

#puts read_sequences('test18.txt')
prof_matrix(read_sequences('test18.txt')).each do |k, v|
  puts "#{k}:   #{v.join(' ')}"
end
puts cons_seq(prof_matrix(read_sequences('test18.txt')))

