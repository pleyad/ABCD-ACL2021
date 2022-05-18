# Comments on Reproducibility, Changes to the original Repos

## DeSSE

The data files have been renamed, so that all have the same form.

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

- [x] Validation set for MinWiki? Split from training in some ratio as ACL2021?

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

- [ ] `process_data.py` and `process_test.py` should probably be unified. Would this work downstream?

### `process_data.py`

For the moment, I only add a CLI, where a user can specify a dataset folder and a split they want to process.
