echo 'ABCDre Info: Creating virtual environment `env` ...'
python3 -m venv env

echo 'ABCDre Info: Activating virtual environment `env` ...'
source env/bin/activate

echo 'ABCDre Info: Installing requirements into `env` ...'
pip install -r requirements.txt