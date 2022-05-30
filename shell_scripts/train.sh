cd $(dirname $0)
source train_config.sh
source $venv_dir/bin/activate

python -u $root_dir/python_scripts/main.py \
  --dataset $dataset \
  --use-cuda $use_cuda \
  --device $device \
  --batch-size $batch_size \
  --epoch $epoch \
  --every-eval $every_eval \
  --after-eval $after_eval \
  --lr-adj $lr_adj \
  --lr $lr \
  --weight-decay $weight_decay \
  --num-heads $num_heads \
  --word-dim $word_dim \
  --hidden-dim $hidden_dim \
  --dropout $dropout \
  --weight-label $weight_label \
  --classifier $classifier \
  --gradient-clip $gradient_clip \
  --root-dir $root_dir/data/$dataset/ \
  --glove-dir $glove_dir
