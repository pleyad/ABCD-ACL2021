#!/bin/bash

echo 'ABCDre Info: Checking for virtual environment `env`.'
if [[ -d "env" ]]
then
    echo "ABCDre Info: Directory 'env' already exists."
else
    echo 'ABCDre Info: Creating virtual environment `env` ...'
    python3 -m venv env
fi

echo 'ABCDre Info: Activating virtual environment `env` ...'
source env/bin/activate

echo 'ABCDre Info: Installing requirements into `env` ...'
pip install -r requirements.txt