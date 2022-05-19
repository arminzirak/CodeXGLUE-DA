#!/bin/bash
#SBATCH --gres=gpu:v100l:1
#SBATCH --job-name=AllM # single job name for the array
#SBATCH --time=12:00:00 # maximum walltime per job
#SBATCH --mem=25G # maximum 100M per job
#SBATCH --cpus-per-task=2
#SBATCH --output=%x.out # standard output
#SBATCH --error=%x.err # standard error
# in the previous two lines %A" is replaced by job

cd /home/arminz/CodeXGLUE-DA/Code-Code/code-refinement/code
source env/bin/activate

bash adapt_med.sh
echo "adaptation finished"
bash test_adapted_med.sh