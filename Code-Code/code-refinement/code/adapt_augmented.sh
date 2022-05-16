#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=XAadaptS # single job name for the array
#SBATCH --time=12:00:00 # maximum walltime per job
#SBATCH --mem=25G # maximum 100M per job
#SBATCH --cpus-per-task=2
#SBATCH --output=%x.out # standard output
#SBATCH --error=%x.err # standard error
# in the previous two lines %A" is replaced by job

cd /home/arminz/CodeXGLUE-DA/Code-Code/code-refinement/code
source env/bin/activate

for repo in https://api.github.com/repos/pjreiniger/snobot2015 https://api.github.com/repos/orientechnologies/orientdb https://api.github.com/repos/CoprHD/coprhd-controller https://api.github.com/repos/dstockwell/chromium https://api.github.com/repos/ihmcrobotics/ihmc-open-robotics-software https://api.github.com/repos/rstudio/rstudio https://api.github.com/repos/realm/realm-java https://api.github.com/repos/wordpress-mobile/WordPress-Android https://api.github.com/repos/geogebra/geogebra https://api.github.com/repos/hazelcast/hazelcast
do
  echo $repo
  python run.py \
    --do_train \
    --do_eval \
    --model_type roberta \
    --model_name_or_path /home/arminz/codebert-base \
    --load_model_path ~/scratch/Xoutputs/train_source/checkpoint-best-ppl/pytorch_model.bin \
    --config_name roberta-base \
    --tokenizer_name roberta-base \
    --data_dir ~/scratch/Xoutputs/reverse/inference_target/best_ppl/ \
    --output_dir ~/scratch/Xoutputs/adapted/reverse/train_source/best_ppl/$repo \
    --max_source_length 256 \
    --max_target_length 256 \
    --beam_size 5 \
    --train_batch_size 32 \
    --eval_batch_size 32 \
    --learning_rate 5e-5 \
    --train_steps 600 \
    --eval_steps 150 \
    --domains target \
    --repo $repo \
    --augmented_data
done