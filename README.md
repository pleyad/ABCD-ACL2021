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

## Evaluation

### For ACL2021/DeSSE Dataset

```bash
bash shell_scripts/evaluate.sh \
    -h data/ACL2021/output.txt \
    -r data/ACL2021/test.simple.txt \
    -m Bilinear \
    -d ACL2021
```

Output:
```
The scores for the model Bilinear on test set ACL2021 are:

#T/SS: 13.873239436619718 (in reference: 9.948474576271186)

Match #SS%: 0.49240506329113926

BLEU score: 36.167308462255455

BERT score: 0.7051444674091498
```

### For MinWiki Dataset
```bash
bash shell_scripts/evaluate.sh \
    -h data/MinWiki/output.txt \
    -r data/MinWiki/test.simple.txt \
    -m Bilinear \
    -d MinWiki
```

Output:
```
The scores for the model Bilinear on test set MinWiki are:

#T/SS: 9.391366393150197 (in reference: 11.330023828435266)

Match #SS%: 0.7237209302325581

BLEU score: 64.14579710934316

BERT score: 0.8697053794215285
```

### Baseline: DisSim

#### Setup

#### Inference: ACL2021/DeSSE

```bash
bash shell_scripts/baseline_dissim_inference.sh \
    -i data/ACL2021/test.complex.txt \
    -o data/baselines/DisSim/ACL2021/output.txt
```

#### Inference: MinWiki

#### Evaluation ACL2021/DeSSE

```bash
bash shell_scripts/evaluate.sh \
    -h data/baselines/DisSim/ACL2021/output.txt \
    -r data/ACL2021/test.simple.txt \
    -m DisSim \
    -d ACL2021
```

Output:
```
The scores for the model DisSim on test set ACL2021 are:

#T/SS: 9.584569732937686 (in reference: 9.948474576271186)

Match #SS%: 0.40759493670886077

BLEU score: 35.53461117958389

BERT score: 0.6784842106554434
```