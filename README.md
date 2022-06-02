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

```bash
bash shell_scripts/python_setup.sh
```

### CoreNLP

This will install CoreNLP inside this directory and set the environment variables used later.
Approximately bash GB will be used by CoreNLP.
If you already have CoreNLP on your system, you might need to adjust some paths in the preprocessing shell script.

```bash
bash shell_scripts/corenlp_setup.sh
```

## Preprocessing

First, CoreNLP needs to be applied to the datasplits.

```bash
# bash shell_scripts/process_dataset_with_corenlp.sh {PATH/TO/DATASET/DIR}
bash shell_scripts/process_dataset_with_corenlp.sh data/ACL2021
bash shell_scripts/process_dataset_with_corenlp.sh data/MinWiki
```

Then, with Python, pickles are created for training the neural model.


```bash
# bash shell_scripts/process_dataset_with_python.sh {PATH/TO/DATASET/DIR} {SPLIT}
bash shell_scripts/process_dataset_with_python.sh data/ACL2021 train
bash shell_scripts/process_dataset_with_python.sh data/ACL2021 valid
# bash shell_scripts/process_dataset_with_python.sh data/ACL2021 test
bash shell_scripts/process_dataset_with_python.sh data/MinWiki train
bash shell_scripts/process_dataset_with_python.sh data/MinWiki valid
# bash shell_scripts/process_dataset_with_python.sh data/MinWiki test
```

Because the testset is processed with `processed_test.py`, which bash havent implemented yet, we cant yet go call the script for the split `test`.

## Training

XXX

## Inference

After obtaining model checkpoints (with training), you can start inferring with your model.
Please insert the right checkpoints directory for option `-c`.

### For MinWiki Dataset

```bash
bash shell_scripts/run_inference.sh \
    -r . \
    -g data/glove \
    -c data/MinWiki/MinWiki_Bilinear_0.0001_main_ep50_hdim800_2022-05-18/ \
    -i data/MinWiki/test.pkl \
    -o data/MinWiki
```

### For ACL2021/DeSSE Dataset

```bash
bash shell_scripts/run_inference.sh \
    -r . \
    -g data/glove \
    -c data/ACL2021/ACL2021_Bilinear_0.0001_main_ep50_hdim800_2022-05-30/ \
    -i data/ACL2021/test.pkl \
    -o data/ACL2021
```

## Inference