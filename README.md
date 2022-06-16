# ABCDre

This repository holds code and data for reproducing the paper **ABCD** by **Gao et al. (2021)**.
It contains a refactored and generalized fork of the repository provided by the original authors.

We tried to stay as closely to the original code as possible.
Errors were fixed with best intentions in mind.
We added command line interfaces to scripts that are exposed to a user, and created shell scripts with specified commands in this README to invoke them reliably.
Missing code, such as the evaluation, was implemented as described in the paper.
When things were underspecified in the paper, which was often the case, we adhered to either default values or industry or research standards.

## Reference

Yanjun Gao, Ting-Hao Huang, and Rebecca J. Passonneau. 2021. [ABCD: A Graph Framework to Convert Complex Sentences to a Covering Set of Simple Sentences](https://aclanthology.org/2021.acl-long.303). In *Proceedings of the 59th Annual Meeting of the Association for Computational Linguistics and the 11th International Joint Conference on Natural Language Processing (Volume 1: Long Papers)*, pages 3919–3931, Online. Association for Computational Linguistics.

# Contents

- `data/`: Original training data, as provided in the [serenayj/DeSSE](https://github.com/serenayj/DeSSE)-Repository.
- `python_scripts/`: Python Scripts
- `shell_scripts/`: Shell Scripts

- `READMEre.md`: Some comments on the changes we had to make to the original repo and the data. This file grew organically, please consider that.

# Assumptions

- UNIX-based System
- Python 3.6.12
- Java (`openjdk 11.0.14.1 2022-02-08`) with Maven

# Usage

All scripts have to be executed from this root folder.

## Setup

### Python-Environment

```bash
bash shell_scripts/python_setup.sh
```

### CoreNLP

This will install CoreNLP inside this directory and set the environment variables used later.
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
bash shell_scripts/process_dataset_with_python.sh data/ACL2021 test
bash shell_scripts/process_dataset_with_python.sh data/MinWiki train
bash shell_scripts/process_dataset_with_python.sh data/MinWiki valid
bash shell_scripts/process_dataset_with_python.sh data/MinWiki test
```

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

BLEU score: 48.76476787443682

BERT score: 0.722607966212532
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

BLEU score: 69.73991636776147

BERT score: 0.8782817620029085
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

```bash
bash shell_scripts/baseline_dissim_inference.sh \
    -i data/MinWiki/test.complex.txt \
    -o data/baselines/DisSim/MinWiki/output.txt
```

#### Evaluation: DeSSE

```bash
bash shell_scripts/evaluate.sh \
    -h data/baselines/DisSim/ACL2021/output.txt \
    -r data/ACL2021/test.simple.txt \
    -m DisSim \
    -d DeSSE
```

Output:
```
The scores for the model DisSim on test set DeSSE are:

#T/SS: 9.584569732937686 (in reference: 9.948474576271186)

Match #SS%: 0.40759493670886077

BLEU score: 35.53461117958389

BERT score: 0.6784842106554434
```

#### Evaluation: MinWiki


```bash
bash shell_scripts/evaluate.sh \
    -h data/baselines/DisSim/MinWiki/output.txt \
    -r data/MinWiki/test.simple.txt \
    -m DisSim \
    -d MinWiki
```

Output:
```
The scores for the model DisSim on test set MinWiki are:

#T/SS: 9.695386961494473 (in reference: 11.330023828435266)

Match #SS%: 0.6734883720930233

BLEU score: 61.51080531201312

BERT score: 0.852477138687606
```