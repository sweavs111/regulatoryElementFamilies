#!/bin/bash
#
#SBATCH --job-name=selfchain
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --mem=32G
#SBATCH --output=lavToAxtArrayOutput/selfChain_%A_%a.out
#SBATCH --error=lavToAxtArrayOutput/selfChain_%A_%a.err

input=$(head -${SLURM_ARRAY_TASK_ID} $1 | tail -1)

lavFile=$(echo $input | cut -d " " -f 1)
p=$(basename $lavFile .lav)
genome=$(echo $input | cut -d " " -f 2)
geno=$(basename $genome .fa)
cs=$(echo $input | cut -d " " -f 3)

kent="/hpc/group/vertgenlab/cl454/bin/x86_64"

#LAV TO AXT
$kent/lavToAxt -fa -tfa $lavFile $genome $genome axt/$p.axt

#AXT SWAP TARGET / QUERY

t=$(echo $p.axt | tr '_' '\t' | cut -f 1)
q=$(echo $p.axt | tr '_' '\t' | tr '.' '\t' | cut -f 2)


if [[ $t != $q ]]
then
	$kent/axtSwap axt/$p.axt $cs $cs axt/${q}_$t.$geno.swap.axt
fi

echo DONE
