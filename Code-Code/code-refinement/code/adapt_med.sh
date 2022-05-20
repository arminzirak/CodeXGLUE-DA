#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=XadaptM # single job name for the array
#SBATCH --time=12:00:00 # maximum walltime per job
#SBATCH --mem=25G # maximum 100M per job
#SBATCH --cpus-per-task=2
#SBATCH --output=%x.out # standard output
#SBATCH --error=%x.err # standard error
# in the previous two lines %A" is replaced by job

cd /home/arminz/CodeXGLUE-DA/Code-Code/code-refinement/code
source env/bin/activate

for repo in https://api.github.com/repos/CoprHD/coprhd-controller https://api.github.com/repos/orientechnologies/orientdb https://api.github.com/repos/wordpress-mobile/WordPress-Android https://api.github.com/repos/ihmcrobotics/ihmc-open-robotics-software https://api.github.com/repos/awaiwyy/UIcase https://api.github.com/repos/caskdata/cdap https://api.github.com/repos/egovernments/eGov https://api.github.com/repos/crate/crate https://api.github.com/repos/MobilityFirst/GNS https://api.github.com/repos/oVirt/ovirt-engine
do
  echo $repo
  python run.py \
    --do_train \
    --do_eval \
    --model_type roberta \
    --model_name_or_path /home/arminz/codebert-base \
    --load_model_path ~/scratch/Xoutputs/50-100/train_source/checkpoint-best-ppl/pytorch_model.bin \
    --config_name roberta-base \
    --tokenizer_name roberta-base \
    --data_dir ../data/datasets/50-100/ \
    --output_dir ~/scratch/Xoutputs/50-100/adapted/train_source/best_ppl/$repo \
    --max_source_length 256 \
    --max_target_length 256 \
    --beam_size 5 \
    --train_batch_size 32 \
    --eval_batch_size 32 \
    --learning_rate 5e-5 \
    --train_steps 600 \
    --eval_steps 150 \
    --domains target \
    --repo $repo
done