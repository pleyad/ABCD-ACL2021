#!/usr/bin/env python3

import argparse

def parse_arguments():

    parser = argparse.ArgumentParser(description="Post-processes DisSim output for ABCDre evaluation.")

    parser.add_argument("-i", "--inpath", help="Path of the DisSim output file.")
    parser.add_argument("-o", "--outpath", help="Path for the post-processed output.")

    args = parser.parse_args()

    return args

INPATH = 'DiscourseSimplification/output_flat.txt'
OUTPATH = 'DiscourseSimplification/postprocessed_dissim.txt'

def postprocess(inpath: str, outpath: str) -> None:
    with open(inpath, 'r') as infile:
        with open(outpath, 'w') as outfile:
            current_complex_sent = None
            simplification_parts = []
            for line in infile:
                fields = line.strip().split('\t')
                complex_sent = fields[0]
                simplification_part = fields[3]
    
                # First Sentence
                if current_complex_sent is None:
                    simplification_parts.append(simplification_part)
                    current_complex_sent = complex_sent
    
                # Same complex sentence
                elif complex_sent == current_complex_sent:
                    simplification_parts.append(simplification_part)
                
                # New complex sentence
                else:
                    outfile.write(f"{' '.join(simplification_parts)}\n")
                    simplification_parts = [simplification_part]
                    current_complex_sent = complex_sent
            
            # Last Sentence cleanup
            if len(simplification_parts) != 0:
                outfile.write(f"{' '.join(simplification_parts)}\n")

def main():
    args = parse_arguments()
    postprocess(args.inpath, args.outpath)

if __name__ == "__main__":
    main()