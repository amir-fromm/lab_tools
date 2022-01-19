### send_wexac.sh
 A wrapper to send jobs to wexac.
 input as follows
 ```
-log <the exact directory of the log folder>
-queue <the name of the queue to which the job is sent>
-name <name of the job as will appear in the log files> 
-memory <memory required (integer) >
-n 10 <number or required threads (integer) >
-job  <the exact job to send to wexac>
```
example code:
 ```
send_wexac.sh -log /parent_directory/project/log/ -queue 'new-short' -name 'example_project_2022' -memory 1000 -n 10 -job "sh /parent_directory/scripts/example_script.sh"
```
The output of the log files (error+output files) will appear in the log folder, inside a folder named after the current date.  
The total required memory is: <-n> * <-memory>

