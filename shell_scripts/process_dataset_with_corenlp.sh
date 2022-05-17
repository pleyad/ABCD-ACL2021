#!/bin/bash

datasetpath=$1
rootdir=$PWD

cd "$datasetpath"

for split in train test valid
do  
    filename="${split}.complex.txt"
    echo "ABCDRe Info: Processing ${filename}"
    java -cp "${rootdir}/corenlp/stanford-corenlp-4.4.0/*" \
        -mx3g edu.stanford.nlp.pipeline.StanfordCoreNLP \
        -file "$filename" \
        -annotators tokenize,ssplit,pos,depparse \
        -ssplit.eolonly
done

cd "$rootdir"