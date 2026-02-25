#!/bin/bash
#SBATCH --mem=50G

if [[ $1 = "" ]]
then
	echo enter a full genome fasta file with repeat masking
	exit 1
fi

printf "input genome: $1\n"

p=$(basename $1 .fa)

#splitByChromName
#cat $1 | grep ">" > $p.chromNames

#mkdir -p byChrom

#while read line
#do
#	name=$(echo "$line" | cut -c 2-)
#	~/go/bin/faFilter -name $name $1 byChrom/$name.$p.fa
#	echo done with $name
#done < $p.chromNames

mkdir -p lastzOutput
rm lastzOutput/*
rm $p.lastzArrayJob.txt
touch $p.lastzArrayJob.txt

for i in byChrom/*fa
do
	num1=$(echo $i | cut -d '.' -f 1 | cut -c 12-)
        for j in byChrom/*fa
        do
		num2=$(echo $j | cut -d '.' -f 1 | cut -c 12-)
		if [[ $num1 > $num2 ]]
		then
			echo lastz $i $j --output=lastzOutput/chr${num1}_chr${num2}.$p.lav --allocate:traceback=1G --scores=human_chimp_v2.mat O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000 C=0 >> $p.lastzArrayJob.txt
		elif [[ $num1 == $num2 ]]
		then
			echo lastz $i --self --output=lastzOutput/chr${num1}_chr${num2}.$p.lav --allocate:traceback=1G --scores=human_chimp_v2.mat O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000 C=0 >> $p.lastzArrayJob.txt
		fi
        done
done

n=$(cat $p.lastzArrayJob.txt | wc -l)


mkdir -p lastzArrayOutput
rm lastzArrayOutput/*
sbatch --array=1-$n 1_1.lastzArray.sh $p.lastzArrayJob.txt

echo DONE
