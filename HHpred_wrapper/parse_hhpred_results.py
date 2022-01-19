#!/usr/bin/python3

import os
import sys
import pandas as pd
import re
import numpy as np
#infile1 = r"\\data.wexac.weizmann.ac.il\vardi\Collaboration\amir_ben\Ostreococcus_genes\HHPRED_OT\output\output\XP_022840970.1.pdb.hhr"
infile1 = sys.argv[1] # input file path
#infile2 = sys.argv[2]
base=os.path.basename(infile1) # get file basename
outfile = os.path.splitext(base)[0] # remove file extention
id_df = pd.DataFrame(columns = ['Gene name','Hit Rank','Hit','Description','Probability','E-value','Score']) # read file into a dataframe, skipping first 2 rows

with open(infile1,"r") as fi: #name the hits found hits using the non-parsed file
    lines = fi.readlines()
    count = 0
    for i in range(0,len(lines)):
        ln = lines[i]
        if re.search("^No [0-9]",ln): #looking only for the header lines that have the relevant information         
           count = count+1
           id_df.loc[str(count),'Hit Rank'] = re.search("No ([0-9]+)",ln).group(1) #get the rank of the hit
           id_df.loc[str(count),'Gene name'] = outfile #get the name of the gene
           ln = lines[i+1] #skips to the next line
           new_ln = ln.replace(">", "")
           new_ln = new_ln.replace('\n',"")
           n = list(new_ln.split('; ')) #get the information in the description line
           n2 = list(n[0].split(' ', 1))
           id_df.loc[str(count),'Hit'] = n2[0] #get the hit name
           if ',' in n2[1]: #save the most informative description line
               id_df.loc[str(count),'Description'] = n2[1]
           elif len(n)>1 :
               id_df.loc[str(count),'Description'] = n[1]
           else:
               id_df.loc[str(count),'Description'] = n
           s = lines[i+2] #skips to statistics line
           dicty = dict(item.split("=") for item in s.split("  ")) #get the information in the statistics line
           id_df.loc[str(count),'Probability'] = dicty['Probab']
           id_df.loc[str(count),'E-value'] = dicty['E-value']
           id_df.loc[str(count),'Score'] = dicty['Score']
           next
    print(type(id_df))
    
  #  df3['domain'] = df3['domain'].str.strip()
id_df.to_csv(os.path.join(outfile+'.tsv'), sep='\t', index=False) # write results into a comma seperated file (csv)

