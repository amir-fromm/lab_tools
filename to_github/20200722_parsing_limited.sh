#!/bin/sh
module load python
module load python/bio-2.7.13

echo "parsing results"
cd output
mkdir -p log
for file in *.hhr
do 
    #echo $file # print path to file
    basefile="$(basename -- $file)" # capture file basename
    echo "processing $basefile" # print file name
    outfile="${basefile%.*}" # remove file extension
    number=$(bjobs -w | wc -l) # get the numbers of jobs running
    while [ "$number" -gt 300 ];do 
       echo "$number"
       sleep 1
       number=$(bjobs -w | wc -l)
    done
    bsub -q new-short  -J log/hhsearch.$outfile.%J -o log/hhsearch.$outfile.%J.o -e log/hhsearch.$outfile.%J.e  -R "rusage[mem=100]" python /home/labs/vardi/amirz/tools/hhpred_codes/parse_hhpred_results_new.py $file
    sleep 0.01
done
