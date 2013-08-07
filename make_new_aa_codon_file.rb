require 'io/console'
require 'yaml'
lines = IO.readlines('aa_codon.txt')
hash = {}
lines.each do |line|
  next if line.nil?
  codon = line[/[=][~]\s..../][4..6]
  aa = line[/[r][e][t][u][r][n]\s../][8]
  aa_name = line[/[#].*/]
  hash[codon] = [aa, aa_name]
end

f = File.new("codons_aa.txt", 'w')
f.write hash.to_yaml
f.close

hash2 = YAML::load_file "codons_aa.txt"
puts hash2
