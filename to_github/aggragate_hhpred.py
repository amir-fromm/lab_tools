#!/usr/bin/python3

import pandas as pd
import os
from argparse import ArgumentParser

def get_args():
    parser = ArgumentParser(description="Aggregate HHpred results into a pivot table")
    parser.add_argument("--in_file", help="Path to the HHpred results (tsv file)", required=True)
    parser.add_argument("--information", help="The type of information given: description or hit", default = "description")
    parser.add_argument("--out_file", help="name of the output file", required=True)

    return parser.parse_args()

def main():
    args = get_args()
    infile1 = args.in_file
    outfile = args.out_file
    info = args.information
    with open(infile1, "r") as fi:
        df = pd.read_csv(fi, sep='\t')
        if info == "description":
            de = df.groupby(['Gene name'])['Description'].apply('|'.join).reset_index()
            de[['Gene name','Database']] = de['Gene name'].str.extract('(^.*)\.(pdb|pfam)', expand=True)
            pivot = de.pivot_table(index = "Gene name", columns = "Database",aggfunc='first', values = "Description")
        elif info == "hit":            
            de = df.groupby(['Gene name'])['Hit'].apply('|'.join).reset_index()
            de[['Gene name','Database']] = de['Gene name'].str.extract('(^.*)\.(pdb|pfam)', expand=True)
            pivot = de.pivot_table(index = "Gene name", columns = "Database",aggfunc='first', values = "Hit")

       # de = df1.set_index('Gene name').combine_first(df2.set_index('Gene name')).reset_index()
    #    pivot.columns = ['Hosts','Viruses']
    pivot = pivot.fillna("NA")
    pivot.to_csv(os.path.join(outfile + '.csv'), sep=',')

if __name__ == '__main__':
    main()
