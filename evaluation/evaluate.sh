#!/bin/bash
PYTHON="python3.6"
while getopts h:r:m:d: flag
 do
    case "${flag}" in
        h) HYPOTHESIS=${OPTARG};;
        r) REFERENCE=${OPTARG};;
        m) MODELNAME=${OPTARG};;
        d) DATASET=${DATASET};;
        *) echo "usage: $0 [-h PATH_TO_HYPOTHESIS] [-r PATH_TO_REFERENCE]" >&2
       exit 1 ;;
    esac
done

if [[ ! -d "eval" ]]; then
  echo "Creating virtual environment"
  $PYTHON -m venv eval

  echo "Activating virtual environment"
  source eval/bin/activate

  echo "Installing the requirements"
  pip install bert-score -q
  pip install sacrebleu -q

else
  source eval/bin/activate
fi

echo "*****Computing the scores*****"
$PYTHON evaluate.py --hypothesis "$HYPOTHESIS" --reference "$REFERENCE" --modelname "$MODELNAME" --dataset "$DATASET"
