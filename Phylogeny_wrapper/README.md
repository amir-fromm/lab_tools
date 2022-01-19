# Phylogeny wrapper
## A wrapper for analyzing the phylogeny of multiple genes, using mafft and RAXML, running on Weizmann LSF system, WEXAC.

### multiple_mafft_AA.sh
Accepts multiple multi-fasta files, each containing a set of amino-acid sequences.
The code uses MAFFT version 7.402 with the LinsI algorithm.
The first argument must be the directory with the multifasta files, in faa format.
The second argument is the memory required for each alignment: for longer sequences, and a large number of sequences, use higher memory.
the output is a multiple-sequence alignment for each of the files.
The memory limit for this code is 300,000 MB.

### multiple_mafft_DNA.sh
Accepts multiple multi-fasta files, each containing a set of nucleotide sequences.
The code uses MAFFT version 7.402 with the LinsI algorithm.
The first argument must be the directory with the multifasta files, in fasta format.
The second argument is the memory required for each alignment: for longer sequences, and a large number of sequences, use higher memory.
the output is a multiple-sequence alignment for each of the files.
The memory limit for this code is 300,000 MB.

### NOTE: RAXML file exept only fasta files with no illegal characters. To remove illegal characters from a multifasta, use the replace_characters.py code.

## replace_characters.py
Replaces illegal characters in an MSA file.
The first argument must be the folder of the processed files, in a .fas format
### NOTE: this code will overrun the previous fasta files

The characters are replaced as follows:
)(][' : Removed
:,; : A space character
           
## multiple_RAXML_AA.sh
Accepts multiple AA multiple-sequence-alignment files, the output of MAFFT, with a .fas suffix.
The code uses RAxML version 8.2.9 with the PROTGAMMAILGX algorithm.
The first argument must be the directory with the multifasta files, in .fas format.
The second argument is the memory required for each alignment: for longer MSA, and a large number of sequences, use higher memory.
The output is a phylogenetic tree for each of the multiple-sequence alignment files.
The memory limit for this code is 300,000 MB.

## multiple_RAXML_AA.sh
Accepts multiple DNA multiple-sequence-alignment files, the output of MAFFT, with a .fas suffix.
The code uses RAxML version 8.2.9 with the GTRGAMMA algorithm.
The first argument must be the directory with the multifasta files, in .fas format.
The second argument is the memory required for each alignment: for longer MSA, and a large number of sequences, use higher memory.
The output is a phylogenetic tree for each of the multiple-sequence alignment files.
The memory limit for this code is 300,000 MB.




