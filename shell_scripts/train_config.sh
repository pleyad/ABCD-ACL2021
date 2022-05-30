# directories
root_dir=/home/domi_zenitram/ABCD-ACL2021
glove_dir=/home/domi_zenitram/glove/
venv_dir=/home/domi_zenitram/venvs/venv_abcd

# device settings
use_cuda=True
device=0

# experiment settings
dataset=MinWiki
batch_size=64
epoch=50
every_eval=1
after_eval=0
lr_adj=0
lr=1e-4
weight_decay=0.99
num_heads=4
word_dim=100
hidden_dim=800
dropout=0.2
weight_label=True
classifier=Bilinear
gradient_clip=None
