# @author OI
# @date August 6, 2013
# this code translates mRNA intro protein seqeucne
require 'yaml'

def mRNA_to_protein(rna_seq)
  codons_aa_hash = YAML::load_file "codons_aa.txt" # {codon: [aa, aa_name]}
  protein_seq = []
  
  seq = convert_u_t(rna_seq)
  codons = get_codons(seq)
  
  codons.each do |codon|
    aa = codons_aa_hash[codon][0]
    protein_seq << aa
  end
  
  protein_seq.join('')
end

def convert_u_t(rna_seq)
  dna_seq = []
  rna_seq.split('').each do |base|
    if base == "U"
      dna_seq << "T"
    else
      dna_seq << base
    end
  end
  
  dna_seq.join('')
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

rna = 'AUGCUCAUCCUGAGUCGCCGAUCUCUAUCGAGGCUGAAUCACUUUCAGGGCAAGCAAGACGGUUCUACAGACUACAUGAACCGCUGCUCCCGGACAGAACCUUCGCAUCGCGACUGGCUUGUUCCGCCAAUAGGCCUUCCCAGAACGAAAUCUAGGGGGCCCACUACUACCCCGUUCGUAAGCGUUAGAGUGCGGUUCAUACUGGUAUAUCCCCCGUACGCUGAGACGUCGAGAGGAGAACCCCCCGGAUUUUCCUCCUGGGCGUCCCCUGAACUCAAUCGACGAAGGAUUUGUGAAUCCGUCUUCGGACAUAAUGCGAUAGGUCGGGUCUUGUCCUUAGGCCUUUGGCCAUAUCCCGAGCAGGCGUUGUCCAAGCAUCACACUCACAUGGAGUUGCGAUCCUCAGAGCCACAACGCCGCCACAAACUUGCCUGGGGUGAGAUGCUCCGAUCUUAUUCCUGUGGACUCCUUAAGGGUCCCGUACGGGGAGACGCGAGGUGCAAGUCAUACAGAAGACGCACGUUAUCCUACUCUAUACGGACGCAGCUUGGGACCCCGACCAACUGCGAUAUCCUUAGACUCGGCCCGCAGCAGGAACGUCUCUGCUACAUCCGUAGGAGUUCCCGCAUCCCCACGCGUGUAAAUUUUAGCAUUAUAGACGGGAACAGGACGGUCAGAGGGAAGAAUCGCUUAGCUCCACGCGAAUCGUCUGGUCUAUCCGUCGCUAGACCUUUUAGUGGAUCGGUGGGAGAACCUCAUUACGAAGGCACCAUGCUGAAUGGGCCCUACACGUGGCCCAAGGGAGCUAAGAAUUGGUUUGGCUCGUCUAACAGUAGAUUCUGUAGCCCCGCGAGCUCGGGCUACUGCGCACGCUGCUGCUCGGGUGUAAUGCCUAACCAACCGCAGGGCAAUUUUAGCCUUGGACAGACCAGAGUUAUGAAUAACUCUGAACACAGGCCAGCACAAGGCCACGACUACCAGUGGUUCCCUGCCGUAGAUCUAAGUCUGAUUGUAUAUCACAAUUGCCCUUCAUGCCCCGCGCGACUCCUGCUCAAGGGGCGGAACAUGGAUCAGUCAUAUGCACUAUUUCCCAACCGGCCUUGCUACGAAAACUUCUUGACCUACCUCUGUAGUCUGUUUCCUUCUGUAGAGUUCGCGUCUCCACGUUUCAAUCGGCUGGGGGGUUUAACGCUUCUUAUAUUCGAAUUAGCGCCCUUAGCGUUGCGAGCGCUACGCAUCAACGCACUCCAUAAAAUUGAGGAUAAUACCGGUCGAUUGGACGUAGCCGUCCGCCCCUCGUCAGUGGGAACGGUGUCAAGUCUGCAGCACAACGUCACCGGAAGUGCUCCAAUAUUUCUCGUCCCACCGCCCCUUCUUUUCACCUCGCAAUCUAGAGUCUACUUUAUUGAGUAUAUCCAUAAAUUCAGCGAGCAGGAAAUAGCAGUACUUUAUGGCAAUGAUCCUAAAAGCCGUUUUCGCAUUGCCCGCUUUUUGCGGGCACCGAGGGAGGUCGAGUAUCCGUACACUCUGAAAUGUCGGAUAUUAUGUAAAUGCCGUAUUAUAUCUAGAAACUUGAGAAUUUUUCCCAUUCACGGCUCCUUGUCUGGGACAUUGAACUCGUACGCGCCUCCAGUUGAGGCGACUGAGCUAAAGCUCGCGGAUAAGGGCACGGCGGGCUCAACUGGCUGGCCUUCCCCGUGGAGCGGUCGGACAUUAUUCUGUCACCUCUCAAAUUGUGCAUACACAUAUGUCAGCACCAUGCACAGUACCAACAAUGGCACUAACACUGCAAGGUUGCGUAGGGGAUUUAAAGGCAACGCGGUGGGAGACGUACUUGGGGGCACGCUCGCGGAGGAUCCGGAGAAAUUAUCUACGCCGGUUAGUAUCAGUUUGGUCAUGGUCUUAAAGGACGUUUAUCGUAACACGGUACCCGUGCGCACUCUGUUCAACUCAGUGCGUAGGGCCGAAACGUGCUGGGAGUUAUAUUCCGAACCUGUUAUAGUACAAGUCCCAUCAGCUGCCUGUAGCGGUCGCUGGUCACAACUACACACUGCAUCAAAGUUUGUGUGCGCCGCUACUAAGAGAUUGGAUGUCCUCUUCCAGCCCAACUCCCUGCACACAAAGGAUUCUCAUGCGGCUGAGAUUCACGAUUUCAUUUGCACUUCUCUGGGAAAGCAUCCCCUAAGUCCCCGGCCGACUAAUCGGAUUAUGCGACGGAGGACAUCGGCUCUCAAGUUCCGCGUGGCCAGCUUGCAGCUAGGGCUUGGACGGCGCUGGUUCAAAUCCCAGAACCGACUUCCGUCCGGCCACCUUUCAAAGUUACCCCUUGACGGACGGCCUCGUGAUCGCUGUAUUCACCGGUCGGGCGGGCUCCAUUGGAGUCUUUCGAGCAGUUUUAAUGUCAUCCUUAGACGUAACACAGUUAUUAUUUGCCCUAGUGAGGUCACUCUCCGCGCGAUGCUCCGUCCGUCGGCGGGGGCGAAAGUUAGCUAUCCGAGGGGCCGCCGUAUACUAUAUGAAAAGAGCUCUAUAGGAACGGGAUGUUCGUUAUCUGCUGCGAGCGCUCACGAGACAUAUCUGUUCUCGAGGGUAGACAAGAAGCGCUACCGAACCGCGCGUUCCUCGAGAGACAAGCCUAUGACGCUACAUUGCCAUCUUUGCUUUACCGGAACGCCGCUCGGCCGGAGUUGUGAUCCAUGGCCCAGCACGCACGUGCGUCUGGGCGGGGACCUAACCCGAAGAAAGUCAAAACCGCGAUUAAAGGUGCAUGUACCAGACUACUUGCUGACAUACACGUUUAGAUCACGAAAGUUUUCAAGAGCGUUGCGUCGCUUAGGCGGCGCAGACCUUUGUUCCAUGAUGACACGCUCCAUGAAAAGCGCUCGUCAUUUAUGCUUCGUAUGUGAUAACGGACUAGAGGGGGCCGGUUGCAUCUCGACGUACGUAAUUUCACUGCCAAAAGACUUAGUCCUCUUUCUUCAUGGCACAGCUUUGCCCGGGCCUGAACCUACGUUCGAGCUGAGUCCAAUCUCCUCGUCCCCGCUCACGAGUAUUCGUCGCGAUACUUCGGAAGCCAACUCGAUCGUCCGUGGAUUGCACGCGCUGGACACGAGUCCACCUCAUCAUAUUUCGUGCCUUGGGUCUAGCAGCGAAACACGAUCGUACUGCCACAAACGUCAUAAAACCAUGGCUCAUGCAGGUGGGCCACAUAGUGACGCCAUGAAACAUUACCUCGGCCGUAAAGCCUAUAAGGGCCAACAAGGACUUGGAUUUGCCUCAAUGCAAGACAACACCAGUACAUUGCCAAAGCACCCUCAUCGGUACAUGGACCCAACUGGAACCGACCUGGGUAAGACUAGAGUUCGCAUGGUUGUAGACCAGUAUCAGAGUCACAGAUUUAGCCCAUGUUACCGGAAAAGUCUGACUUCAUUAAAACCCCUCCAUCGUGAGUUGCCACUGAACGACGGCCUAGGAACAUUAUAUAUGUACCACAUAUACGACGCCUGGGCUAGUAUCCAAUUAUUUCGGCUGACUGCCGGAGUCGACCAACAUCGGCUGUCUGAAGUCCCACCCAAGCUCUCAAGCGGUAGCAACCGCGUACGGACAGAGAUGCCGAAGACUUCCCCCCCUAAUUCAUUCGCGAAUUGUUGCCAAGCAAGUAGUCGUCAGGUCUGUGGUACCUUUUCAAUUCUGUACAGACUAACUUACCCGGCCCAGCGGGGUAGGAGGGUUCUUCACGGUCUAAUCUCACCAUGUAAAGAAAGUACAGCUGAGUUGUCCAACAUAGAUUCCCUCCUCGUAGUUCCGGUUGGGAUCGAGAUAGCGUCCAGCAUGAGGCGGACGGUUGACCUUGUGAGUCCGAAGCACGGGACCAUUUCGAGACCGCCUCCUCCCGAUCCAGUGCGCCAGGGCAGGGAGUCUGGUCUCACCCCCGUGGAAGUGGGUCUGAGCGGACUACACUUCGACGCAUCAUCCAAUUUCCGCAUAAGUGGCCCUAGGUUUCAGAAGGGUAAGCUUCGGAAUCGCGCGGGAGUCUCCGCGCAGCGUUGUAAGUGGUCGCUCUUGGGAAUAUAUCUAACUGCACCAGUGUGUUCCACAAUAUUAAGUCGCCCGGCGUGCUGUCAACGCGAACAUGAGGCAUGGGCCCUAUCCCUGUGCGUAAGCUUUAAAAAUUCGGAAAAGUCGUCAGGGACCCCGGGCGCCUGGUCACUGCCAUGUCCGUUCGCGUUCGGUACCUGGCAAGAGCCUGCUAGUCUAACUAACUUAUUACUAAUUUGUAGAUUGUACUCAUUUGGAGUAUUCUAUUCGCAAGAAAACGGACAACAGAGAUCUCACACCGAUAACUGGGCGAGGAUCAAAUGGCCCAGGCACACUAUAUCCUCGACGACCUUUGUUAGAGAAGAUUUCGGGCACGGUUGCGAUGUACAAUCAAGUAUGAAGUGCGUGUCGGACAUUGCGUACUGGAGACUAGGUGGACCGUUUCGGUGCGUGCGAUUUUACAACCCACGUACGGUAUAUUUGUGCGCAUUUUUUUCUCCCAAGGUCGUGAUUCGUCGUGGUAGGCUCGGUUCAAUCGGGAUUGUGCCCCUAUGUCGGACUGCUGAACAUGACCACAAUGAUUCCAGACUUAAUAACCCGGUAAAGACCUUACCAAACACUGGGUCCCAAUUAUAUUGGACUUCCCCGCUGUUCGGCUUGUUGAUGCUAUGUUUACGCCUACAUCCGACGAACUCCAACCGUUCCUAUCUAGGAACCGCCAUCUGGUCCCUCAUAGAGCGCGCUCAAGCGUAUGGGGAGCUCAAGAUAUUAGCGAGUCUGGAAGUGCGAAUGCUCGAUACGGAGACAUCUGACUUCAUUUUGCUCACACGAAAAUCUCCGAAGCAAAAUGAAACAAGUGAGGCAGACCUUCUACCCCGGUUGCUAAGGAGCUUUCUUCCCUCACGCGACAUGUUUCUUACAGUUCCUGGGUUUUGCAAUUGUAGGAGAUUAGAGCAUCAGCUAGAGGGGGGCCCGAGUUCGGACGGCCCAGUUGAAGUGGCUGCAAUGGGUACUAGGGAACCCAAUGCGGGAGGACCGAAUUUAAACUGUGCUAUGGCGGCGCCUCACCGGGUAGAAAAAAUACACGGACUGACCAGGGGUCACUACAGGCAUUCUUUGGCCCCAUCAAUGUUAUUGCCAGGUCUGGUGUUCUACAGAUUUUGUUCUACGUGGAGGCGCCAUGGCAGAGACUCUUAUUAUGUCGGAGGUUACGGGGUAACAGGCAUGGUACUCGUUAGCUCGCUACCUAAGUUAUUCGUAGAGCGAUUUGGAAAGGAGCCCUUGUGGCUACUCUGCCCCUGUACAGUAUAUGCGCCUUCAUUGUGCUUGGAGUCACUCCGGAUAAUGCUGGACCUGGUGUCCCUGUAUGAUCUUGAGACUCGCUCGAGUUACCCUUCAACCCGCUUUGUGUACUGGGCGUCAGGGAUACUUCCAUUUGUAUUUAGUCACUGCCUGCUUGUCGAACUAUCCGGCUGUGUCGUACAAAUACAUCAUGCGAGGACGCGGCCGCGUCACACUGGUCUAAGCGCGGUAUGGAGGGCGUCGAUCCUGUUAUCAGAUUCGUACUCACGUCUUACGUUGGGUGGGUUGCACUGGGACUUACUCCCGCCCACGUUAGAAACUAGGAGAGUCUCGAAAUCAGCAGCGCCUAGCUCAGAACAAUCAACCACUAUAGACGCGCGAGGAACCUUUGCUCAUUACAUUAUGGCCGAGUCCUCAAUCUCUAGACAUUGCAAACCGGGGCUAACCGGUCCAGAUUCGGCGGGACAAAGGCACGGCUGGUCACGGCUGGCCGGAUCGGAACCGAGCCCACGUUGCGGGUCCGCUUCCCACGUCGAUUCACAGCAUCUGUAUGGCACAAUACAACUCCGACCCCGGAGACGCCUUAACCAAGAUCGAGGCAAGUAUCUGAUUGCAGCCAUAAGUACAAUUCUAGUGCUGCAUUGGAAAUUGCAUAGCGGAUGGUGGCAUAUGUCGUGUCUAAAUCAUCCACACGUGGACAGCUUUAGCGAGAGAACGUACCACUCUCACUUAACCGAAAGGCAGUCUAACAGAUGCCACAAGAAGUAUCAACCCUUGGCCGAAAUCGUGUCGACGCAUAGUAACGGAGAGGCUCCGGAGAUAGUUCUAGGAUGGCAAUGUAUGAGGCACCUUUCCGCUCGUAUAGGCCUCACCUCGAGCUGCACCUUAAGCAAUUUUCGUACUCUUAAGGUUGGUUUACAUAGUAUAUUGAAUCCUCUUGUAAAUGAGGACCGGUGGGCCGCUCCCGAUUCAACUACUCUCCUGACGCGCUGUUAUGUUAUCUCGAUAGGAAAGCUACCCGACUUAUGCCCACUGAAGACUCUGACAAUAUCCAUAACCCGGUUAUCCGCUUUUAGCUUAGAAGUGUUUUAUACUCUUAAAGCCACAGAAAUCGUCAUACCGAAUGGACUUGCCAAAGUAAGGAGAACACAUGCAGUUGACAUACAGGCUAAGCUCCUAAAGAAUUGUCUCCACAGACGCCUCGCGGAUCGGCCCCUUGUUGAUUCGCGAUCGGACUGCACACAUCUAGAAUGUAACAGUCUAGGCCAUUUACAUAUUGCAGUCUCAUGGGAAUCCUCCCAACCGUGCUGUUUCGAAGUCAUCAUGCAAAUAGAUAGUCUUAAGGUAAAUGACAUCGUAUCACAAUCUAAUAAGGCACACGUACGCAAGUGUACCGACAAUUAUACAUCAAAUUGUCUAAGUGUAUUGAUGGGAGAUAUAGCAUGGGAAUUCAUGCCAACGGUAGUAACGGGGGUCAGAUGUCUCUUGGCCGUCCCUAGUUCUGGCACCAGACACGCUGGUGCCCCGAUACCACCCUAUGCCACCAGCCCUAAGUCUGCGCUAGAAGCAACAUUUAAAACAUUUAUAAAAGUGAGUAGCCUACUUCUCUGUAAUGCAUCGUUUCACCGUUUACCUCAAGACCCCGUUCGAUUGCAAAGCGUCUCUUACCACUCUCCCUUACUAAGAGUUCUGGACCCAACUGCUAUCUGUAUGCCUACUCCUAUACAUUCAGCGACAAGAAUGGAAAAACGGAUACGUUGGACCACUAGCUAUCAGGCUGCCAAGCAGAGGUCUAUGCGAAGGAUUAGGGAUGAUUGUUGCGGCGGGGGCUACCACUUGCCUAGUAAACGUACGAAUCAUCUAAUUUUUCCAAAUUUCCGCCUUGUAGGGAGUAUCGAAUAUCAUUGCGGACCGCGCGGUUUAGGUCGUCGUAUCUGUUCUGAAUUGCGCAGGGGUCCGACUCCACAUCGUUUAAUGUGCAAAAGUCAUGGCACCUCUCCGCCGUGGUUACUCGAUGCAGGAGUUAAAUUAUACAGCGUAAUUUGGAAUCGAUCUACCUUUUCAAGCAGUGCCACCACGAUGCUUGGCUUACAUAACCAACCAUACAGCAUGUCCUUCACCUGUACGUAUACCAGGCCAGUUUGCAGCGUUCUGCGCAAUUCUCUUGGCGACGGUGGUUCCAGACGAGGAGUGCGACGACUCACUUGUGGCUGUAUUAUCUACUCAGUGUGGGCCGUGCCACGCUCUGUCCAGCACCGUUGCCAUCGACCUAGAUUUAUGAUAUGUAUAGCGGGGUGGGCAUGCAUGGCCGGUAUCAGAACUGCUCCCCGAACAUUUAGGGAUGCAUUACACGCCCGGAUUUUAGAUAGAUUUACUAGAUUCAGGGCAAAAAUUUCUAGAGGGCAUUGGCAGAGAGGACGUCUAACUAACCCGUGGACCGUACCUAUGAGUCGAAUUUCGGAUCAGGCGUGGAUUGAGUACACGCUAGGCUUGUAUCCAUCGAAGCCAGUCUAUUCAAAGACACACCUGACCCAACAUAAUCAAAGACCGGUCGUAUUCAGGUUUGCGAUCACCCACGUUGGAGUGCAUGACCGUUCUACACCACAGACCAGUGAUCGUUCUUUAAGCGGCAAGCGGAUUAGCGCAUUGUUCAGCAAGUCCAGGCAAUGGGUGCAUCCAUUUUGCCGUUGUCAAUGUUUGGGAUGUGCAGUGUUAGUUUCAAAGCGUCCACCAUUUUGUAACUCACCCAAUUGUGCGCAGCCGGCUGUCUUUGACGCCCGCCCCCGCUUUUCACGCAGACAGCAAGAGGAGAGAGGCAACGUAGGUGACCGGAUGCCUUAUCAGAGGACGAUUUUGCAUACUUUUCCGAUAAUCCGAUAUGACGGAUCAGUCCAUCACCGUCGGUUUCUUCGAAAGUUGUUUACGCAAAGGUCAGUUUACGCAGCGCUCGGCCAUGCACUAAAUUACUUACCGCACACGCCGAACCAGUUUGAGGGGCUGAGAGUGCCCCUUUGCUUUAGUGUUCCUAUCAUAGAUAAUCGAGCACGACUGGUAGAGGGUAAUAGUUCGGGAUCCCGCGAAACAAGACCUAACUAUAAAAAAGAGGUACACUACGUCAUGGUCUGUAGGUUGGGUAUAGUGAUACCUCGCUUUAUAAUGGUUCCGUUGCUUCCCUUGUCACACCUUUUGGAUCAAAUGUAUAUAGAUACAUCGGAAGGGCUAUAUCAGCAUAGAAGCAUCAGACGGCAAUGUGACAAUCGGGCGACCAUGCACGCACGCUGGAUGCCAGGUACCUGGACAUGGUUCCCCCUUUCGUCUGACGCGGGACUUUCAGAGCAAGAGGUGACUAGGGUGGAGCGUUCGUUAGAGAAACAAAACAAAAUCUCUGUGGUCGCCCUCGGGACGAGUCUUCGAAUGUUCUGCGCAUGUCGUCCGUCCAGAACCCUUCUGAGCAACCUCUCUGGGGAUCAUUAUGUGCGUGAUUUGAUGGUGCAGUGCCCCACGACACUAUCUCGAUGGCUGUCAAUACUCAAACUUCUUAUAGGCUUUGAGCAAAGAAGUCCUUCCCGAUCUGCACUAAAACCGACGGUUUGCGGGCGGUCCACUAUCCUCACACUGAUAUACGAGCAUUCCCAGUUCCUAGGCCAGACCGAUCACUUGUUUGUUGCAUAUAGCUUCUUUGGCGCGCACUCCUCAGCGAUUAGGUCGGUUGAACGGAAUACACGCAGCUUACUCUUUAAUCGGGUCGAUCCUCCUCGGGUUGAGAGACCGAGCUUAUGCCGAGCAGGCAUGGAUUCCAGAAAUCCGUGUUAUCGAAAGCCAGUUGAGCUUACUGAUCACGGAACUAGGAACCCAGUUCGGCCUAGUCCACCACGACGCAUCGUAGUCUCAGCCUCGCAUCAUCUAAAUUUAACGGGAUCCUAG'
protein = 'MAMAPRTEINSTRING_'

res = mRNA_to_protein(rna)
puts res