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
| `MinWiki/matchvp_train.simple` | `MinWiki/train.complex.txt` |

- [ ] Validation set for MinWiki? Split from training in some ratio as ACL2021?

## `process_data.py` vs `process_test.py`

`process_data.py` expects a datasplit where gold labels are present, and can therefore not be used for deployment.

`process_test.py` processes complex sentences (and their CoreNLP-dependencies) as if there were no gold labels (would probably be called something with `deployment` in proper ML-lingo).

- [ ] `process_data.py` and `process_test.py` should probably be unified. Would this work downstream?

### `process_data.py`

For the moment, I only add a CLI, where a user can specify a dataset folder and a split they want to process.
