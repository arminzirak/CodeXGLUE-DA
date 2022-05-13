#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=XtrainS # single job name for the array
#SBATCH --time=60:00:00 # maximum walltime per job
#SBATCH --mem=25G # maximum 100M per job
#SBATCH --cpus-per-task=2
#SBATCH --output=%x.out # standard output
#SBATCH --error=%x.err # standard error
# in the previous two lines %A" is replaced by job

cd /home/arminz/CodeXGLUE-DA/Code-Code/code-refinement/code
source env/bin/activate

python run.py \
	--do_train \
	--do_eval \
	--model_type roberta \
	--model_name_or_path /home/arminz/codebert-base \
	--config_name roberta-base \
	--tokenizer_name roberta-base \
	--data_dir ../data/datasets/50/ \
	--output_dir ~/scratch/Xoutputs/train_source \
	--max_source_length 256 \
	--max_target_length 256 \
	--beam_size 5 \
	--train_batch_size 32 \
	--eval_batch_size 32 \
	--learning_rate 5e-5 \
	--train_steps 100000 \
	--eval_steps 5000 \
	--domain source \
