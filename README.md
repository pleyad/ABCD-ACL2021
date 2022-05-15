# ABCDre

This repository/branch contains the cleaned up ABCD-Repository.

# Contents

- `scripts/`: Shell Scripts
- `data/`: Original training data, as provided in the [serenayj/DeSSE](https://github.com/serenayj/DeSSE)-Repository.

# Assumptions

- UNIX-based System
- Python 3.6.12
- Java (`openjdk 11.0.14.1 2022-02-08`)

# Usage

All scripts have to be executed from this root folder.

## Setup

### Python-Environment

```
. shell_scripts/python_setup.sh
```

### CoreNLP

This will install CoreNLP inside this directory and set the environment variables used later.
Approximately 1 GB will be used by CoreNLP.
If you already have CoreNLP on your system, you might need to adjust some paths in the preprocessing shell script.

```
. shell_scripts/corenlp_setup.sh
```

## Preprocessing

First, CoreNLP needs to be applied to the datasplits.

```
# . shell_scripts/process_dataset_with_corenlp.sh {PATH/TO/DATASET/DIR}
. shell_scripts/process_dataset_with_corenlp.sh data/ACL2021
. shell_scripts/process_dataset_with_corenlp.sh data/MinWiki
```

Then, with Python, pickles are created for training the neural model.


```
# . shell_scripts/process_dataset_with_python.sh {PATH/TO/DATASET/DIR} {SPLIT}
. shell_scripts/process_dataset_with_python.sh data/ACL2021 train
. shell_scripts/process_dataset_with_python.sh data/ACL2021 valid
# . shell_scripts/process_dataset_with_python.sh data/ACL2021 test
. shell_scripts/process_dataset_with_python.sh data/MinWiki train
. shell_scripts/process_dataset_with_python.sh data/MinWiki valid
# . shell_scripts/process_dataset_with_python.sh data/MinWiki test
```

Because the testset is processed with `processed_test.py`, which I havent implemented yet, we cant yet go call the script for the split `test`.