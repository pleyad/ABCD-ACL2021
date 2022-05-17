# Comments on Reproducibility, Changes to the original Repos

## DeSSE

The data files have been renamed, so that all have the same form.

| Old | New |
|-|-|
| `ACL2021/test.complex.txt` | `ACL2021/test.complex.txt`
| `ACL2021/test.simple.txt` | `ACL2021/test.simple.txt` |
| `ACL2021/train.complex` | `ACL2021/train.complex.txt` | 
| `ACL2021/train.simple` | `ACL2021/train.simple.txt` | 
| `ACL2021/valid.complex` | `ACL2021/valid.complex.txt` | 
| `ACL2021/valid.simple` | `ACL2021/valid.simple.txt` |
| `MinWiki/matchvp_test.complex` | `MinWiki/test.complex.txt` |
| `MinWiki/matchvp_test.simple` | `MinWiki/test.simple.txt` |
| `MinWiki/matchvp_train.complex` | `MinWiki/train.complex.txt` |
| `MinWiki/matchvp_train.simple` | `MinWiki/train.simple.txt` |
|  | `MinWiki/valid.complex.txt` |
|  | `MinWiki/valid.simple.txt` |

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

## `process_data.py` vs `process_test.py`

`process_data.py` expects a datasplit where gold labels are present, and can therefore not be used for deployment.

`process_test.py` processes complex sentences (and their CoreNLP-dependencies) as if there were no gold labels (would probably be called something with `deployment` in proper ML-lingo).

- [ ] `process_data.py` and `process_test.py` should probably be unified. Would this work downstream?

### `process_data.py`

For the moment, I only add a CLI, where a user can specify a dataset folder and a split they want to process.
