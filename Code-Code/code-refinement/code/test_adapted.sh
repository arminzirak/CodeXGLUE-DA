#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=XtestA # single job name for the array
#SBATCH --time=4:00:00 # maximum walltime per job
#SBATCH --mem=25G # maximum 100M per job
#SBATCH --cpus-per-task=2
#SBATCH --output=%x.out # standard output
#SBATCH --error=%x.err # standard error
# in the previous two lines %A" is replaced by job

cd /home/arminz/CodeXGLUE-DA/Code-Code/code-refinement/code
source env/bin/activate

for repo in https://api.github.com/repos/pjreiniger/snobot2015 https://api.github.com/repos/orientechnologies/orientdb https://api.github.com/repos/CoprHD/coprhd-controller https://api.github.com/repos/dstockwell/chromium https://api.github.com/repos/ihmcrobotics/ihmc-open-robotics-software https://api.github.com/repos/rstudio/rstudio https://api.github.com/repos/realm/realm-java https://api.github.com/repos/wordpress-mobile/WordPress-Android https://api.github.com/repos/geogebra/geogebra https://api.github.com/repos/hazelcast/hazelcast
do
  echo $repo #TODO: replace codebert with roberta
  python run.py \
    --do_test \
    --output_dir ~/scratch/Xoutputs/test/adapted/train_source/best_ppl/$repo\
    --load_model_path ~/scratch/Xoutputs/adapted/train_source/best_ppl/$repo \
    --model_type roberta \
    --model_name_or_path /home/arminz/codebert-base  \
    --config_name roberta-base \
    --tokenizer_name roberta-base \
    --data_dir 	../data/datasets/50/ \
    --max_source_length 256 \
    --max_target_length 256 \
    --beam_size 5 \
    --eval_batch_size 32 \
    --domains target \
    --repo $repo
done