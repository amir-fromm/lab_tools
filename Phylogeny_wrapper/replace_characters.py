# -*- coding: utf-8 -*-
"""
Created on Wed Dec  9 15:52:40 2020

@author: amirz
"""
import glob, os
#
out_path = r"\\data.wexac.weizmann.ac.il\vardi\Collaboration\compare_viruses\phylogeny\new_clusters\output\selection"
os.chdir(out_path)

for file in glob.glob("*.fas"):
    with open (file,'r') as fasta_file:
        text = fasta_file.read()
        for c in ")(]['":
            text = text.replace(c, "")
        for c in ":,;":
            text = text.replace(c, "_")

    with open (file,'w') as fasta_file:
        fasta_file.write(text)
