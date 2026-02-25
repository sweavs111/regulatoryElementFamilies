#!/bin/bash
#SBATCH --mem=50G


mkdir -p annotations/enrichments/200bp
rm annotations/enrichments/200bp/*

ls annotations/*forOE.bed annotations/repeatByType/*.bed > annotations/oeInputFiles.txt

touch annotations/enrichments/200bp/tmp

for i in families/200bp/*forOE.bed
do
	printf "calcating enrichments with the $i set\n"
	while read line
	do
		p=$(echo $i | cut -d '.' -f 5)
		if [[ $p = "forOE" ]]
		then 
			p="allElements"
		fi
		printf "calculating enrichments with $line\n"
		~/go/bin/overlapEnrichments -trimToSearchSpace normalApproximate $i "$line" hs1.noGap.bed stdout >> annotations/enrichments/200bp/tmp
	done < annotations/oeInputFiles.txt

	cat annotations/enrichments/200bp/tmp | grep '#' | sort -u > annotations/enrichments/200bp/enrichMatrix.$p.txt
	cat annotations/enrichments/200bp/tmp | grep -v '#' >> annotations/enrichments/200bp/enrichMatrix.$p.txt
	rm annotations/enrichments/200bp/tmp
done

echo DONE

