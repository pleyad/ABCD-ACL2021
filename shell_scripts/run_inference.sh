#!/bin/bash
PYTHON="python"

# Importing the command `abcdreinfo`
source $(dirname "$0")/utils.sh

# Help message
_HELP="usage: $0 [-r path] [-g path] [-c path] [-i path] [-o path]

where:
    -r Path to the root directory (root folder of this repo)
    -g Path to the GloVe directory 
    -c Path to the model checkpoints directory
    -i Path to the pickled input text
    -o Path to the directory for the output-files (1 .txt and 1 .pkl)"

while getopts :r:g:c:i:o: flag; do
    case "${flag}" in
        r) ROOTDIR=${OPTARG};;
        g) GLOVEDIR=${OPTARG};;
        c) CHECKPOINTDIR=${OPTARG};;
        i) INPUTPKL=${OPTARG};;
        o) OUTPUTDIR=${OPTARG};;
        *) echo "${_HELP}" >&2
       exit 1 ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
  echo "$_HELP" >&2
  exit 1
fi

abcdreinfo "ABCDre Info: Ensuring Output Directory."
mkdir -p $OUTPUTDIR

abcdreinfo "ABCDre Info: Running inference script."
python3 -u python_scripts/test.py $ROOTDIR \
    $GLOVEDIR \
    $CHECKPOINTDIR \
    $INPUTPKL \
    $OUTPUTDIR