#!/bin/bash
PYTHON="python"
while getopts :h:r:m:d: flag; do
    case "${flag}" in
        h) HYPOTHESIS=${OPTARG};;
        r) REFERENCE=${OPTARG};;
        m) MODELNAME=${OPTARG};;
        d) DATASET=${OPTARG};;
        *) echo "usage: $0 [-h PATH_TO_HYPOTHESIS] [-r PATH_TO_REFERENCE] [-m NAME_OF_MODEL] [-d NAME_OF_DATASET]" >&2
       exit 1 ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
  echo "usage: $0 [-h PATH_TO_HYPOTHESIS] [-r PATH_TO_REFERENCE] [-m NAME_OF_MODEL] [-d NAME_OF_DATASET]" >&2
  exit 1
fi

 if [[ ! -d "eval" ]]; then
   echo "Creating virtual environment"
   $PYTHON -m venv eval

   echo "Activating virtual environment"
   source eval/bin/activate

   echo "Installing the requirements"
   pip install -r requirements_eval.txt

 else
   source eval/bin/activate
 fi

echo "*****Computing the scores*****"
$PYTHON python_scripts/evaluate.py --hypothesis "$HYPOTHESIS" --reference "$REFERENCE" --modelname "$MODELNAME" --dataset "$DATASET"
