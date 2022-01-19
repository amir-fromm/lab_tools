#!/bin/sh

module load python
module load hhsuite
module load python/bio-2.7.13

DIR=$1

mkdir -p output # create an output dir (if not already exist)
mkdir -p log # create a temporary folder

for file in $DIR*.faa
do 
    #echo $file # print path to file
    basefile="$(basename -- $file)" # capture file basename
    echo "processing $basefile" # print file name
    outfile="${basefile%.*}" # remove file extension
    number=$(bjobs -w | wc -l) # get the numbers of jobs running
    while [ "$number" -gt 50 ];do 
       echo "$number"
       sleep 1
       number=$(bjobs -w | wc -l)
    done
    bsub -q new-short  -J log/hhsearch.$outfile.%J -o log/hhsearch.$outfile.%J.o -e log/hhsearch.$outfile.%J.e  -R "rusage[mem=4000]" hhsearch -i $file -o "output/$outfile.pdb.hhr" -e 0.05 -d  /shareDB/hhsuite/pdb70/pdb70 >> "log/$outfile.hhpred.pdb.log"
    sleep 0.1
    bsub -q new-short  -J log/hhsearch.$outfile.%J -o log/hhsearch.$outfile.%J.o -e log/hhsearch.$outfile.%J.e  -R "rusage[mem=4000]" hhsearch -i $file -o "output/$outfile.pfam.hhr" -e 0.05 -d /shareDB/hhsuite/pfam/pfam >> "log/$outfile.hhpred.pfam.log"
sleep 0.1
done
