#!/bin/bash

echo "ABCDre Info: Checking for directory for glove 'data/glova'."
if [[ -d "data/glove/" ]]
then
    echo "ABCDre Info: Directory 'data/glove/' already exists."
else
    echo "ABCDre Info: Creating directory for CoreNLP 'data/glove/' ..."
    mkdir data/glove
fi
cd data/glove

curl -LJO https://huggingface.co/stanfordnlp/glove/resolve/main/glove.6B.zip
unzip glove.6B.zip

cd ../..