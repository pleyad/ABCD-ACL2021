#!/bin/bash
PYTHON="python"

source $(dirname "$0")/utils.sh

abcdreinfo "HASHA"
echo "trrr"
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
        *) echo "usage: $0 " >&2
       exit 1 ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
  echo "$_HELP" >&2
  exit 1
fi

echo -e "${_S}ABCDre Info: Ensuring Output Directory.${_E}"
mkdir -p $OUTPUTDIR

echo -e "${_S}ABCDre Info: Running inference script.${_E}"
python3 -u python_scripts/test.py $ROOTDIR \
    $GLOVEDIR \
    $CHECKPOINTDIR \
    $INPUTPKL \
    $OUTPUTDIR