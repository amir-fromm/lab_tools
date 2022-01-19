# Phylogeny wrapper
## A wrapper for analyzing the phylogeny of multiple genes, using mafft and RAXML, running on Weizmann LSF system, WEXAC.

### multiple_mafft_AA.sh
Accepts multiple multi-fasta files, each containing a set of amino-acid sequences.
The code uses MAFFT version 7.402 with the LinsI algorithm.
the output is a multiple-sequence alignment for each of the files.
The memory limit for this code is 300,000 MB.

### multiple_mafft_DNA.sh
Accepts multiple multi-fasta files, each containing a set of nucleotide sequences.
The code uses MAFFT version 7.402 with the LinsI algorithm.
the output is a multiple-sequence alignment for each of the files.
The memory limit for this code is 300,000 MB.

## multiple_RAXML.sh
Accepts multiple multiple-sequence-alignment files, the output of MAFFT.
The code uses RAxML version 8.2.9 with the PROTGAMMAILGX algorithm.
the output is a phylogenetic tree for each of the multiple-sequence alignment files.
The memory limit for this code is 300,000 MB.




