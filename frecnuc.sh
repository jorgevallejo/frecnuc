#! /bin/bash

# Combine GAWK with fold to calculate the frecuency (absolute and relative)
# of each nucleotide in a genomic sequence from a text file in FASTA format.

# This will cover only the case in wich the file contains ONLY one sequence.

# 1. Get rid of the FASTA head.

# 2. Count all nucleotides

# 3. Count the nucleotides of each type

# 4. Print results (absolute and relative).


gawk '{if ($0 !~/^>/) print tolower($0);}' $1 | fold -w1 |
gawk 'BEGIN{c=0; g=0; t=0; a=0}
     {if($1 !~/[c|g|t|a]/) 
         {print "\nThis is not a valid DNA sequence, it contains", $1,"\n";
          fail=1; exit}
     else if($1 == "c") c++;
     else if($1 == "g") g++;
     else if($1 == "t") t++;
     else if($1 == "a") a++;}
     END{if(fail==1) exit
         format = "%s: %d (%.2f)\n"
         print ""
         print "Sequence size: "NR" nucleotides"
         printf format, "C", c, c/NR 
         printf format, "G", g, g/NR 
	 printf format, "T", t, t/NR 
	 printf format, "A", a, a/NR
         print ""}'


### Extension for the future: More than one sequence in the same file.

### Expand for RNA and aminoacid sequences
