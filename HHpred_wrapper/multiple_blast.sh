#!/bin/sh

module load ncbi-blast+/2.10.1 

DIR=$1

mkdir -p output # create an output dir (if not already exist)
mkdir -p log # create a temporary folder

for file in $DIR*.faa
do 
    echo $file # print path to file
    basefile="$(basename -- $file)" # capture file basename
    echo "processing $basefile" # print file name
    outfile="${basefile%.*}" # remove file extension
    number=$(bjobs -w | wc -l) # get the numbers of jobs running
    while [ "$number" -gt 150 ];do 
       echo "$number"
       sleep 1
       number=$(bjobs -w | wc -l)
    done
    bsub -q new-short -J log/blast.$outfile.%J -o log/blast.$outfile.%J.o -e log/blast.$outfile.%J.e  -R "rusage[mem=200]" blastp -db /shareDB/blastdb/nr/Jul-2020/nr -evalue 5e-2 -word_size 2 -outfmt "6 qseqid sseqid stitle slen qlen staxids pident length mismatch gapopen qstart qend sstart send evalue bitscore" -query $file -out output/$outfile.tsv
    sleep 0.5
done

