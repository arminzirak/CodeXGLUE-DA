#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=XtestM # single job name for the array
#SBATCH --time=2:00:00 # maximum walltime per job
#SBATCH --mem=25G # maximum 100M per job
#SBATCH --cpus-per-task=2
#SBATCH --output=%x.out # standard output
#SBATCH --error=%x.err # standard error
# in the previous two lines %A" is replaced by job

cd /home/arminz/CodeXGLUE-DA/Code-Code/code-refinement/code
source env/bin/activate

python run.py \
	--do_test \
	--output_dir ~/scratch/Xoutputs/50-100/train_included/best_ppl/ \
	--load_model_path ~/scratch/Xoutputs/50-100/train_included/checkpoint-best-ppl/pytorch_model.bin \
	--model_type roberta \
	--model_name_or_path /home/arminz/codebert-base\
	--config_name roberta-base \
	--tokenizer_name roberta-base \
	--data_dir 	../data/datasets/50-100/ \
	--max_source_length 256 \
	--max_target_length 256 \
	--beam_size 5 \
	--eval_batch_size 32 \
	--domains target
