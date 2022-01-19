
# HHpred wrapper
## A wrapper for HHpred module, running on Weizamnn LSF system, WEXAC
### Written by Amir Fromm

The wrapper searches a large number of saparated protein sequences against databases in WEXAC, then parse the results and aggregate them into a csv.

The files must be executed in the order they are listed.

### 01.run_hhsearch_pdb_pfam.sh
Searches a large number of saparated protein sequences against databases in WEXAC, using hhpred.
The search is limited to 250,000 MB of required memory.
The code should be executed using bash inside a folder that contains saparated sequences, in .faa format.

#### Optional codes to run before:
split a large multi-fasta file to saparated faa files with one sequence in each file:
```
cat multi-fasta.fasta |\awk '/^>/ {if(N>0) printf("\n"); printf("%s\n",$0);++N;next;} { printf("%s",$0);} END {printf("\n");}' |\split -l 2 --additional-suffix=.faa - seq_
```
name each faa file by its header:
```
for i in *.faa; do 
     mv $i $(head -1 $i | cut -f1 -d ' '| tr -d '>' |tr -d '\r').faa
done
```


The output is a folder named output, with .hhr files in the name of the sequences.

### 02.parsing_hhpred_limited.sh
Parse the .hhr files into tsv files, using the python code: parse_hhpred_results.py
The code is limited to 300,000 MB of required memory.
The file should be executed using bash inside the folder that contains the saparated sequences, as the previous code.
The output is a matching .tsv file for each .hhr file created previously.

### 03.aggragate_hhpred.py
#### This is an optional code
Aggragate a tsv file to a csv file that saves required information about the genes listed in the tsv file.
The output is a csv file when each line is a pdb or a pfam result of one gene, and an aggaragation of the description or accession number (hit) of all the results for the gene in the tsv file, saparated by ' | '.
Because the code aggragate all the results for the gene, it is better to take only the best hits for each gene.

#### Optional codes to run prior to running this code:
Combine the tsv files into one file:
```
awk '(NR == 1) || (FNR > 1)' output/*.tsv > summary_hhpred_pdb_pfam.tsv
```
Filter the combined file to only contain the top 5 significant hits:
```
awk 'BEGIN {FS="\t"};NR==1; NR > 1 { if ($2 <= 5 &&  $6 <= 0.05) print }' summary_hhpred_pdb_pfam.tsv > top5_sig_pdb_pfam.tsv
```
Dependencies:
python/bio-2.7.13

The code runs with python with the following arguments:
--in_file (required): Path to the HHpred results (tsv file)
--out_file (required): name of the output file 
--information (default:"description"): The type of information given. options are description or hit
example:
```
python aggragate_hhpred_new.py --in_file top5_sig_pdb_pfam.tsv --out_file top5_sig_pdb_pfam --information "hit"
```
### multiple_blash.sh
#### This is an optional code
Searches a large number of saparated protein sequences against databases in WEXAC, using blast.
Similar to the HHpred wrapper, the code should be executed using bash inside a folder that contains saparated sequences, in .faa format.
The output is a .tsv file for each .faa file.
The code is limited to 300,000 MB of required memory.



