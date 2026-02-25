#!/bin/bash
#
#SBATCH --job-name=selfchain
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --mem=32G
#SBATCH --output=lastzArrayOutput/selfChain_%A_%a.out
#SBATCH --error=lastzArrayOutput/selfChain_%A_%a.err

command=$(head -${SLURM_ARRAY_TASK_ID} $1 | tail -1)
srun $command

echo DONE
