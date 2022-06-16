#!/bin/bash

PROJECTROOT="$(dirname "$(dirname "$(realpath -s "$0")")")"

# Importing the command `abcdreinfo`
source $(dirname "$0")/utils.sh

abcdreinfo "Changing to DisSim directory."
cd baselines/DisSim

abcdreinfo "Attempting to clone DisSim repository"
if [[ ! -d "DiscourseSimplification" ]]; then
  abcdreinfo "Cloning the DisSim repository"
  git clone https://github.com/Lambda-3/DiscourseSimplification
else
  abcdreinfo "Dir DiscourseSimplification already exists"
fi

cd DiscourseSimplification

abcreinfo "Installing DisSim with Maven"
mvn clean install -DskipTests

