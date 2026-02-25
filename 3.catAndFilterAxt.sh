#!/bin/bash
#SBATCH --mem=32G

if [[ $1 = "" ]]
then
	echo enter the same genome fasta file as before
	exit 1
fi

printf "input genome: $1\n"

p=$(basename $1 .fa)

#mkdir -p axt/combined
#rm axt/combined/*

#cat axt/*axt > axt/combined/$p.selfAlign.axt

#~/go/bin/axTools -minSize 1000 axt/combined/$p.selfAlign.axt axt/combined/$p.selfAlign.1kb.axt
~/go/bin/axTools -minSize 200 axt/combined/$p.selfAlign.axt axt/combined/$p.selfAlign.200bp.axt
echo DONE
