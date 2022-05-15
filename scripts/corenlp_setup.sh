#!/bin/bash

echo "ABCDre Info: Checking for directory for CoreNLP 'corenlp'."
if [[ -d "corenlp/" ]]
then
    echo "ABCDre Info: Directory 'corenlp' already exists."
else
    echo "ABCDre Info: Creating directory for CoreNLP 'corenlp' ..."
    mkdir corenlp
fi
cd corenlp

echo "ABCDre Info: Checking for source."
if [[ -f "stanford-corenlp-latest.zip" ]]
then
    echo "ABCDre Info: File 'stanford-corenlp-latest.zip' already exists."
else
    echo "ABCDre Info: Getting source ..."
    curl -O -L http://nlp.stanford.edu/software/stanford-corenlp-latest.zip
    unzip stanford-corenlp-latest.zip
fi 

echo "ABCDre Info: Adding CoreNLP jar-paths to environment variables."
for file in `find stanford-corenlp-4.4.0/ -name "*.jar"`
do
    export CLASSPATH="$CLASSPATH:`realpath $file`"
done

cd ..
