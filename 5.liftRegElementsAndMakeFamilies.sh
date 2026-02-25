#!/bin/bash
#SBATCH --mem=100G

#trim bed region by 50%

if [[ $1 = "" ]]
then
	printf "intputs: \n 1. bed file of regulatory elements\n 2. genome prefix (eg: if the genome is hs1.fa, provide hs1)\n"
	exit 1
fi

printf "user inputs\n $1\n $2\n"

bd=$(basename $1 .bed)

mkdir -p families
rm families/*


~/go/bin/bedTrim -trimPercent 50 $1 families/$bd.trim50.bed

~/go/bin/liftWithAxt axt/combined/$2.selfAlign.1kb.axt families/$bd.trim50.bed $2.chromSizes families/$bd.lift.bed families/$bd.liftAndMerge.bed

~/go/bin/familiesFromLiftAndMerge families/$bd.liftAndMerge.bed families/$2.regEleFam.bed families/$2.regEleFam.txt /dev/null

cat families/$2.regEleFam.bed | grep -v "lonely" > families/$2.regEleFam.noLonely.bed

cat families/$2.regEleFam.noLonely.bed | grep "homologous" > families/$2.regEleFam.noLonely.homologous.bed
cat families/$2.regEleFam.noLonely.bed | grep -v "homologous" > families/$2.regEleFam.noLonely.OCR.bed

for i in families/*noLonely*
do
	p=$(basename $i .bed)
	cat $i | cut -f 1-3 > families/$p.forOE.bed
done


echo DONE
