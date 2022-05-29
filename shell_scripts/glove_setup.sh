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

if [[ -f "glove.6B.100d.txt"]]
then
    echo "ABCDre Info: GloVe files already available."
else
    echo "ABCDre Info: Downloading GloVe from Huggingface ..."
    curl -LJO https://huggingface.co/stanfordnlp/glove/resolve/main/glove.6B.zip
    
    echo "ABCDre Info: Unzipping GloVe ..."
    unzip glove.6B.zip
fi

cd ../..