#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=XtestAM # single job name for the array
#SBATCH --time=4:00:00 # maximum walltime per job
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
    --do_test \
    --output_dir ~/scratch/Xoutputs/50-100/test/adapted/reverse/train_source/best_ppl/$repo\
    --load_model_path ~/scratch/Xoutputs/50-100/adapted/reverse/train_source/best_ppl/$repo/checkpoint-best-ppl/pytorch_model.bin \
    --model_type roberta \
    --model_name_or_path /home/arminz/codebert-base  \
    --config_name roberta-base \
    --tokenizer_name roberta-base \
    --data_dir 	../data/datasets/50-100/ \
    --max_source_length 256 \
    --max_target_length 256 \
    --beam_size 5 \
    --eval_batch_size 32 \
    --domains target \
    --repo $repo
done