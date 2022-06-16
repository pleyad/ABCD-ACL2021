# Comments on Reproducibility, Changes to the original Repos

## Setup Working Environment - Logs

### Python

Using `pyenv` to manage python version `3.6.15` (newest `3.6` version) with a virtual environment.

### CoreNLP

Following this [official Instruction](https://stanfordnlp.github.io/CoreNLP/download.html#steps-to-setup-from-the-official-release), I install CoreNLP.

It requires Java, so I first install Java via these [Instructions](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04-de).

I created the shellscript `corenlp/setup.sh` to set the environment variables.
As described in the documentation, we might want to move this to .bashrc/.zshrc.

### GloVe

https://github.com/serenayj/ABCD-ACL2021#get-pre-trained-word-embeddings

I download GloVe as demanded, around 830 MB (zipped).
Furthermore, we need to unzip it ()

### Models (for [Testing](https://nlp.stanford.edu/projects/glove/))
I downloaded the two models for testing (ca 40 and 96 MB)


### Python Virtual Invironment

Some Dependencies aren't listed or listed incompletely:

- `pandas` isn't listed
- `torchtext` needs to be on version `0.7` to be compatible with `torch==1.6.0`
- `pickle5` is required only `pickle`


## Testing

[`python process_test.py`](python process_test.py)

Doesn't work yet, because in the `data/` directory, there is only the *unprocessed* `test.complex`.
We need to run

```bash
java -cp "/path/to/jarfiles/*" -mx3g edu.stanford.nlp.pipeline.StanfordCoreNLP -file test.complex
```

in my case:

```bash
java -cp "/home/pankraz/computerlinguistik/rnlp/ABCDre/corenlp/stanford-corenlp-4.4.0/*" -mx3g edu.stanford.nlp.pipeline.StanfordCoreNLP -file test.complex
```

Furthermore, several paths in the cfg of `test.py` need to be adjusted.

## Datasets

The reported numbers for the datasets don't quite match up with the actual number of training examples in the provided repository.
It could be rounding errors, but they would've rounded in the wrong direction (❓)

For our fork, the  data files have been renamed, so that all have the same form.

| Old | `wc -l` | New | `wc -l` |
|-|-|-|-|
| `ACL2021/test.complex.txt` | 790 | `ACL2021/test.complex.txt` | 790 |
| `ACL2021/test.simple.txt` | 790 | `ACL2021/test.simple.txt` | 790 |
| `ACL2021/train.complex` | 13199 | `ACL2021/train.complex.txt` | 13199 |
| `ACL2021/train.simple` | 13199 | `ACL2021/train.simple.txt` | 13199 |
| `ACL2021/valid.complex` | 42 | `ACL2021/valid.complex.txt` | 42 |
| `ACL2021/valid.simple` | 42 |`ACL2021/valid.simple.txt` | 42 |
| `MinWiki/matchvp_test.complex` | 2150 | `MinWiki/test.complex.txt` | 1074 |
| `MinWiki/matchvp_test.simple` | 1074 | `MinWiki/test.simple.txt` | 1074 |
| `MinWiki/matchvp_train.complex` | 18746 | `MinWiki/train.complex.txt` | 18687 |
| `MinWiki/matchvp_train.simple` | 18746 | `MinWiki/train.simple.txt` | 18687 |
| | | `MinWiki/valid.complex.txt` | 59 |
| | | `MinWiki/valid.simple.txt` | 59 |

### MinWiki Validation

MinWiki doesn't have a validation set, but the model uses the evaluation on a validation set for early stopping.
Therefore, we check the ratio between training and validation set in ACL2021, and then split of a validation set from the end of the MinWiki training set in the same ratio.

```
ACL_train = 13199
ACL_val = 42
MinWiki_train = 18746

After Split:
MinWiki_val : 13199 / 42 = (18746 - x) / x -> x = 59
MinWiki_train = 18746 - 59 = 18687
```
### MinWiki Test mismatch

The original test files in MinWiki have a mismatch:
The `test.complex` has twice as many lines as `test.simple`.
Upon further inspection, it becomes clear that in `test.complex`, the sentence ending punctuation is on its own line:

```
The doctor is evil
.
Therefore we must run
.
```

It is unclear to us how this worked out for the original authors.

We correct this in our repo, so that the files have the same number of lines, similar to the ACL2021 dataset.

```
The doctor is evil.
Therefore we must run.
```

## `process_data.py` vs `process_test.py`

`process_data.py` expects a datasplit where gold labels are present, and can therefore not be used for deployment.

`process_test.py` processes complex sentences (and their CoreNLP-dependencies) as if there were no gold labels (would probably be called something with `deployment` in proper ML-lingo).

### `process_data.py`

To check if everything probably works (🤞), I create a tiny dataset with only the 50 topmost lines of each of the files in `DeSSE/ACL2021/`.

At first, I process the data with CoreNLP.

Looking at the script `process_data.py`, it appears that three files in the data directory are expected:

- `data/clean_orig_sent_0.txt`
- `data/clean_gold_sent_0.txt`
- `data/clean_orig_sent_0.txt.out`

The last file is the output of CoreNLP on `data/clean_orig_sent_0.txt`.

At first, I adjusted the hardcoded paths.

Secondly, I had to adjust the for-loop on ca. line 95, so that not only one single line gets processed. I suspect they were debugging and didn't get the code back to the general case.

Because the `process_data.py` gets confused when NER is also annotated, I specify that it ONLY does depparse (and required steps for depparse):

💥 This command breaks the pipeline downstream, because some lines are combined into one sentence! 💥 
```bash
java -cp "/home/pankraz/computerlinguistik/rnlp/ABCDre/corenlp/stanford-corenlp-4.4.0/*" -mx3g edu.stanford.nlp.pipeline.StanfordCoreNLP -file train.complex -annotators tokenize,ssplit,pos,depparse
```

✔ This command should work ✔
```bash
java -cp "/home/pankraz/computerlinguistik/rnlp/ABCDre/corenlp/stanford-corenlp-4.4.0/*" -mx3g edu.stanford.nlp.pipeline.StanfordCoreNLP -file train.complex -annotators tokenize,ssplit,pos,depparse -ssplit.eolonly
```
I needed to adjust a small detail where the dependencies are read from the CoreNLP-output (ca line 100). **TODO**: In general, I think it would be nice to rework the CoreNLP-output-parser, at the moment it is a very ugly and un-pythonic string-matching boogaloo. A class would be perfect.

Then, we need to download some nltk resources:

```python
>>> import nltk
>>> # For sent_tokenize function
>>> nltk.download('punkt')
```

Furthermore, I needed to adjust the way the last sentence is read in (ca line 101). If left as it was, the header was somehow included, what caused an error in GetDeps().

Next, the pickling is commented out in the original script. I uncomment it again, and remember that because of weird dependency stuff we might use the wrong pickle protocol.

## ACL2021/DeSSE Inference

There appears to be a single sentence in the test set that causes a KeyError during inference.
It is the sentence on line `517`, which is on the longer side of sentences.
Even after extensive debugging, what caused the error couldn't be pinpointed.
It is probably somewhere in preprocessing.
To deal with the error, we wrapped the line(s) in `test.py ` where the error occured in a try-except-statement, and output an empty sentence if the error occurs.

## Evaluation

On WSL2 (Ubuntu), I had some troubles running our own evaluation.
If you experience issues as well, please consider these sites, which helped me.

Rust: https://linuxhint.com/install-rust-on-ubuntu/

Pillow: https://techoverflow.net/2022/04/16/how-to-fix-python-pillow-pip-install-exception-requireddependencyexception-jpeg/