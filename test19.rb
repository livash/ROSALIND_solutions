# @author OI
# @date August 5, 2013
# this code finds the longest common substring among
# DNA sequences (< 1kb each) loaded from a file in FASTA format

require 'set'

def longest_substring(file_name)
  sequences = read_sequences(file_name)
  substrings = []
  i = 0
  while i < 3 #sequences.length - 1
    substrings << common_substrings(sequences[i], sequences[i + 1])
    if substrings.length > 1
      subs1 = substrings.pop
      subs2 = substrings.pop
      substrings << common(subs1, subs2)
    end
    i += 2
  end
  #in case number of sequences is not even
  if sequences.length % 2 > 0
      substrings << common_substrings(sequences.first, sequences.last)
  end 
  
  long_sub = 'A'
  longest_common_substring(substrings).each do |sub|
    long_sub = sub if sub.length > long_sub.length
  end
  
  long_sub
end

def read_sequences(file_name)
  file = File.read(file_name)
  file[0] = ""
  records = file.split(">")
  puts "finished reading #{records.length} sequences....."
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

def common_substrings(seq1, seq2)
  puts "Calc common subs......."
  subs1 = substrings(seq1)
  subs2 = substrings(seq2)
  
  common(subs1, subs2)
end

def common(subs_arr1, subs_arr2)
  res = Set.new
  subs_arr1.each do |sub|
    res << sub if subs_arr2.include?(sub)
  end
  puts "Finish calc common subs....."
  
  res
end

def substrings(string)
  puts "Start calculating substrings..."
  res = Set.new
  letters = string.split('')
  i = 0
  while i < letters.length
    j = i + 4
    while j < letters.length
      res << letters[i..j].join('').to_sym
      j += 1
    end
    i += 1
  end
  puts "Finish calc substrings......."
  
  res
end

#puts substrings('serious')

def longest_common_substring(array_of_subs)
  puts "Calculating last step ........"
  return array_of_subs if array_of_subs.length == 1
  
  res = []
  len = array_of_subs.length
  i = 0
  while i < len - 1
    res << common(array_of_subs[i], array_of_subs[i + 1])
    i += 2
  end
  
  if len % 2 > 0
    res << common(array_of_subs.first, array_of_subs.last)
  end
  
  res = longest_common_substring(res)
  
  res
end

file_name = 'test19.txt'
longest_substring(file_name).each do |sub|
  puts sub
end