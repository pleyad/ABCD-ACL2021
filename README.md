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

## Setup

### Python-Environment

```
. scripts/python_env.sh
```

### CoreNLP

This will install CoreNLP inside this directory and set the environment variables used later.
Approximately 1 GB will be used by CoreNLP.
If you already have CoreNLP on your system, you might need to adjust some paths in the preprocessing shell script.
