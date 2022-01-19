

#!/bin/bash


while test $# -gt 0; do
           case "$1" in
                -queue)
                    shift
                    queue_argument=$1
                    shift
                    ;;
                -log)
                    shift
                    log_argument=$1
                    shift
                    ;;
                -name)
                    shift
                    name_argument=$1
                    shift
                    ;;
                -memory)
                    shift
                    memory_argument=$1
                    shift
                    ;;
                -n)
                    shift
                    n_argument=$1
                    shift
                    ;;
                -job)
                    shift
                    job_argument=$1
                    shift
                    ;;
                *)
                   echo "$1 is not a recognized flag!"
                   exit
                   ;;
          esac
  done  
DATE=$(date +%y%m%d)
mkdir -p $log_argument/$DATE
log_folder=$log_argument/$DATE
bsub -q $queue_argument -J $log_folder/$name_argument -o $log_folder/$name_argument.%J.o -e $log_folder/$name_argument.%J.e -R rusage[mem=$memory_argument] -n $n_argument $job_argument




