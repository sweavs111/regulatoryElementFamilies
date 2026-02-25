#!/bin/bash
#SBATCH --mem=50

if [[ $1 = "" ]]
then
        echo provide the same fasta file as in script 1
        exit 1
fi

printf "input genome: $1\n"

geno=$(basename $1 .fa)

/hpc/group/vertgenlab/cl454/bin/x86_64/faSize -tab -detailed $1 > $geno.chromSizes

cat $geno.chromSizes | grep -v "chrM" | awk -v OFS="\t" '{print $1, "0", $2}' > $geno.noGap.bed

# LAV to AXT

rm -rf axt
mkdir -p axt

kent="/hpc/group/vertgenlab/cl454/bin/x86_64"

rm $geno.lavToAxtJobs.txt
touch $geno.lavToAxtJobs.txt

for i in lastzOutput/*.lav
do
	p=$(basename $1 *.lav)
	echo $i $1 $geno.chromSizes >> $geno.lavToAxtJobs.txt
done

n=$(cat $geno.lavToAxtJobs.txt | wc -l)

mkdir -p lavToAxtArrayOutput
rm lavToAxtArrayOutput/*

sbatch --array=1-$n 2_1.lavToAxtArray.sh $geno.lavToAxtJobs.txt

echo DONE

