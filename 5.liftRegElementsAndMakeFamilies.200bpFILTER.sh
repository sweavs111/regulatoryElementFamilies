#!/bin/bash
#SBATCH --mem=100G

#trim bed region by 50%

if [[ $1 = "" ]]
then
	printf "intputs: \n 1. bed file of regulatory elements\n 2. genome prefix (eg: if the genome is hs1.fa, provide hs1)\n 3. out directory prefix (directory will be within \"families\". Must be unique to other runs, or it will overwrite files.)\n"
	exit 1
fi

printf "user inputs:\n $1\n $2\n $3\n"

bd=$(basename $1 .bed)

mkdir -p families/200bp/$3

#~/go/bin/bedTrim -trimPercent 50 $1 families/200bp/$3/$bd.trim50.bed

#~/go/bin/liftWithAxt axt/combined/$2.selfAlign.200bp.axt families/$bd.trim50.bed $2.chromSizes families/200bp/$bd.lift.200bp.bed families/200bp/$bd.liftAndMerge.200bp.bed
#~/go/bin/liftWithAxt axt/combined/$2.selfAlign.200bp.axt families/200bp/$3/$bd.bed $2.chromSizes families/200bp/$3/$bd.lift.200bp.bed families/200bp/$3/$bd.liftAndMerge.200bp.bed

~/go/bin/familiesFromLiftAndMerge families/200bp/$3/$bd.liftAndMerge.200bp.bed families/200bp/$3/$3.$2.regEleFam.200bp.bed families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.txt /dev/null

cat families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.bed | grep -v "lonely" > families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.noLonely.bed

cat families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.noLonely.bed | grep "homologous" > families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.noLonely.homologous.bed
cat families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.noLonely.bed | grep -v "homologous" > families/200bp/$3/cmDiff_fqComb.$2.regEleFam.200bp.noLonely.OCR.bed

#for i in families/200bp/*noLonely*
#do
#	p=$(basename $i .bed)
#	cat $i | cut -f 1-3 > families/200bp/$p.200bp.forOE.bed
#done


echo DONE
