#!/bin/bash
#SBATCH --mem=32G

if [[ $1 = "" ]] 
then
	printf "inputs:\n 1: liftAndMergeBedFile\n 2. open chromatin region for graph building\n"
	exit 1
fi

printf "inputs:\n 1: $1\n 2: $2\n"

mkdir -p pdf

~/go/bin/familiesFromLiftAndMerge -startNode $2 $1 /dev/null /dev/null /dev/null | sfdp -Tpdf -Goverlap=true > pdf/graph.$2.pdf

echo DONE

