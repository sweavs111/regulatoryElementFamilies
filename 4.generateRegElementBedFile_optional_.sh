#!/bin/bash
#SBATCH --mem=40G
#SBATCH -c 4

if [[ $1 = "" ]]
then
	echo step 4 required arguments: 1. genome.fa 2. outprefix \(if multiple runs, this must be unique\) 3. fastq file \(R1\) 4. \(optional\) R2 fastq file \(gziped\)
	echo This step can be skipped if you have a bed file of regulatory element peaks from annother source. The genome must match with the genome that you have been using for the self alignments
	exit 1
fi

printf "user inputs:\n $1 \n $2 \n $3 \n $4 \n"

module load BWA
module load samtools

p=$(basename $1 .fa) 

#mkdir -p ${p}BwaIndex
#rm ${p}BwaIndex/*

#bwa index $1
#mv $1.* ${p}BwaIndex


mkdir -p regulatoryElements

outdir=$(dirname $3)


if [[ $4 = "" ]]
then
	bwa mem -t 4 ${p}BwaIndex/$1 $3 > $outdir/$2.$p.sam
else
	bwa mem -t 4 ${p}BwaIndex/$1 $3 $4 > $outdir/$2.$p.sam
fi

samtools view -@ 4 -hb $outdir/$2.$p.sam > $outdir/$2.$p.bam
samtools sort -@ 4 $outdir/$2.$p.bam > $outdir/$2.$p.sort.bam
samtools index -@ 4 $outdir/$2.$p.sort.bam

rm $outdir/$2.$p.sam
rm $outdir/$2.$p.bam

mkdir -p $outdir/macsPeaks

macs3 callpeak --outdir $outdir/macsPeaks -f AUTO -t $outdir/$2.$p.sort.bam -g hs -n $2.$p

echo DONE


