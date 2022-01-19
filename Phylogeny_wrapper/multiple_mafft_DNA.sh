#!/bin/sh

module load mafft 



DIR=$1
MEM=$2

MEM_LIM=c=$((300000/MEM))

mkdir -p output # create an output dir (if not already exist)
mkdir -p log # create a temporary folder

for file in $DIR*.fasta
do 
    echo $file # print path to file
    basefile="$(basename -- $file)" # capture file basename
    echo "processing $basefile" # print file name
    outfile="${basefile%.*}" # remove file extension
    number=$(bjobs -w | wc -l) # get the numbers of jobs running
    while [ "$number" -gt $MEM_LIM ];do 
       echo "$number"
       sleep 1
       number=$(bjobs -w | wc -l)
    done
    bsub -q new-short  -J log/mafft.%J -o log/mafft.%J.o -e log/mafft.%J.e  -R "rusage[mem=$MEM]" "/apps/RH7U2/gnu/mafft/7.402/bin/mafft-linsi  $file > output/$outfile.fasta"
    sleep 1
done