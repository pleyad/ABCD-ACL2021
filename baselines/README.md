# ABCD Baselines

I cloned the baseline repos in this folder, but ignored them with `.gitignore`.
| Baseline | Repo |
|-|-|
| DisSim | [https://github.com/Lambda-3/DiscourseSimplification](https://github.com/Lambda-3/DiscourseSimplification) |

## DisSim

The first baseline *DisSim* is in the Repo `DiscourseSimplification`.
It is a Java Application and requires `maven` to be run.
The install command (as described in the repos readme) needs to be run inside the repo.
```bash
mvn clean install -DskipTests
```

### Running DisSim

To simplify, a file with one complex sentence per line needs to be named `input.txt` and placed in the root folder of the repo.
Otherwise, the command will throw an error.

```bash
mvn clean compile exec:java
```

There will be lots of verbose output, so if you want to inspect it further, you might want to redirect the output to a file.

After the program is finished, two new files have been created in the root folder of the repo: `output_default.txt` and `output_flat.txt`

Interesting to us is `output_flat.txt`, which is in `.tsv` format.

However, some post-processing needs to be run for it to be in the same format as the gold standard provided in DeSSE.
In the gold standard, all the newly created sentences corresponding to one complex sentence are on the same line.
I wrote the postprocessing script `postprocess_dissim.py` to deal with that.
It doesn't read in arguments, so the filenames are hardcoded variables and need to be adjusted eventually.

💥 The output of DisSim is tokenized. Output sentences therefore contain artifacts such as `[...] I do n't want to . [...]` 
How will the evaluation scripts react to that?
