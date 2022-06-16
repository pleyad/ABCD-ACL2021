#!/bin/bash

_HELP="usage: $0 [-i INPUT] [-o OUTPUT]"

while getopts :i:o: flag; do
    case "${flag}" in
        i) INPUT=${OPTARG};;
        o) OUTPUT=${OPTARG};;
        *) echo "${_HELP}" >&2
       exit 1 ;;
    esac
done

# If run without arguments
if [ $OPTIND -eq 1 ]; then
  echo "$_HELP" >&2
  exit 1
fi

PROJECTROOT="$(dirname "$(dirname "$(realpath -s "$0")")")"

# Importing the command `abcdreinfo`
source $(dirname "$0")/utils.sh

abcdreinfo "Changing to DisSim directory."
cd baselines/DisSim

if [[ ! -d "DiscourseSimplification" ]]; then
  abcdreinfo "Dir \`DiscourseSimplification\` does not exist, run \`baseline_dissim_setup.sh\` first."
fi

abcdreinfo "Copying INPUT into DisSim-Repo as \`input.txt\`"
cp "${PROJECTROOT}/${INPUT}" DiscourseSimplification/input.txt

abcdreinfo "Running DisSim with Maven"
cd DiscourseSimplification
mvn clean compile exec:java
cd ..

# Deal with output
abcdreinfo "Postprocessing DisSim"
python postprocess_dissim.py \
  -i DiscourseSimplification/output_flat.txt \
  -o "${PROJECTROOT}/${OUTPUT}"

rm DiscourseSimplification/input.txt
rm DiscourseSimplification/output_flat.txt
rm DiscourseSimplification/output_default.txt