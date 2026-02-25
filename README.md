Regulatory Element Families

This is a bash pipeline to generate families of regulatory elements within a genome.
Inputs to this pipeline:
  1. A refernce genome
  2. A set of regulatory element annotations (or a fastq file of epigenetic data, which will be turned into a regulatory element set in step 4)

Run any function without arguments to see the options for that function.

REQUIREMENTS:
1. BWA
2. Samtools
3. Gonomics (https://github.com/vertgenlab/gonomics; specifically the functions liftWithAxt.go and familiesFromLiftAndMerge.go must be executable in the users' /bin/)
5. macs3 (if providing fastq files in step 4)
