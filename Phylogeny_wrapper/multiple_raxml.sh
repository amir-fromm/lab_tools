#!/bin/sh
#
module load RAxML/8.2.9
DIR=$1
pwd=$(pwd)
mkdir -p output # create an output dir (if not already exist)
mkdir -p log # create a temporary folder

for file in $DIR*.fas
do 
    echo $file # print path to file
    basefile="$(basename -- $file)" # capture file basename
    outfile="${basefile%.*}" # remove file extension
    echo "processing $basefile" # print file name
    number=$(bjobs -w | wc -l) # get the numbers of jobs running
    while [ "$number" -gt 18 ];do 
    echo "$number"
     sleep 3
     number=$(bjobs -w | wc -l)
    done
    bsub -q new-short  -J log/raxml$file.%J -o log/raxml$file.%J.o -e log/raxml$file.%J.e  -R "rusage[mem=5000]" -n 2 raxmlHPC -f a -p 12345 -s $file -x 12356 -# 100 -m PROTGAMMAILGX -w $pwd/output -n $outfile.txt
    sleep 2 
done

