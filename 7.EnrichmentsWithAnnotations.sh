#!/bin/bash
#SBATCH --mem=50G


mkdir -p annotations/enrichments
rm annotations/enrichments/*

ls annotations/*forOE.bed annotations/repeatByType/*.bed > annotations/oeInputFiles.txt

touch annotations/enrichments/tmp

for i in families/*forOE.bed
do
	printf "calcating enrichments with the $i set\n"
	while read line
	do
		p=$(echo $i | cut -d '.' -f 4)
		if [[ $p = "forOE" ]]
		then 
			p="allElements"
		fi
		printf "calculating enrichments with $line\n"
		~/go/bin/overlapEnrichments -trimToSearchSpace normalApproximate $i "$line" hs1.noGap.bed stdout >> annotations/enrichments/tmp
	done < annotations/oeInputFiles.txt

	cat annotations/enrichments/tmp | grep '#' | sort -u > annotations/enrichments/enrichMatrix.$p.txt
	cat annotations/enrichments/tmp | grep -v '#' >> annotations/enrichments/enrichMatrix.$p.txt
	rm annotations/enrichments/tmp
done

echo DONE

