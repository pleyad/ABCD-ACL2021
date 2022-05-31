#!/bin/bash

rootdir=$PWD
glovedir=$1
checkpointsdir=$2
inputpkl=$3
outputdir=$4

echo "ABCDre Info: Ensuring Output Directory."
mkdir -p $outputdir

echo "ABCDre Info: Running inference script."
python3 -u python_scripts/test.py $rootdir \
    $glovedir \
    $checkpointsdir \
    $inputpkl \
    $outputdir