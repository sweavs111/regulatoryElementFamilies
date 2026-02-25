Regulatory Element Families

This is a bash pipeline to generate families of regulatory elements within a genome. 
Call the bash scripts in order.

Inputs to this pipeline:
  1. A reference genome
  2. A set of regulatory element annotations (or a fastq file of epigenetic data, which will be turned into a regulatory element set in step 4)

The outputs will contain a clusters of putative regulatory elements that contain >70% sequence identity within a cluster. All clusters will be given a unique identifier.
Specific outputs:
1. A bed file of all input regulatory elements partitioned by either "lonely" (not in a family) or the name of the family that element belongs to.
2. Text file containing family name, elements within that family, and percent identitiy statistics.
3. Optional text file containing plotting information useful for plotting clusters using the igraph R library.

Run any function without arguments to see the options for that function.

REQUIREMENTS:
1. BWA
2. Samtools
3. Gonomics (https://github.com/vertgenlab/gonomics; specifically the functions liftWithAxt.go and familiesFromLiftAndMerge.go must be executable in the users' /bin/)
5. macs3 (if providing fastq files in step 4)
