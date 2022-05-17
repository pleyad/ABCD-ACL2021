#!/bin/bash

datasetpath=$1
rootdir=$PWD

echo "ABCDre Info: Processing dataset at ${datasetpath}."
for split in train valid
do  
    echo "ABCDre Info: Start processing split ${split}."
    python python_scripts/process_data.py "$datasetpath" "$split"
done

echo "ABCDre Info: Start processing split test."
python python_scripts/process_test.py "$datasetpath"
