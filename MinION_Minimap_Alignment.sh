# Read variables from the parameters.
# I expect all 4 vars
# r=reference
# R=Reads
# n=name (Some text I'm appending to a few files, call it something useful)
# m=minimumReadSize
while getopts r:R:n:m: option
do
case "${option}"
in
r) ReferenceInputFile=${OPTARG};;
R) ReadInputFile=${OPTARG};;
n) AlignmentPrefix=${OPTARG};;
m) MinimumReadSize=$OPTARG;;
esac
done

# Generate some variables
OutputSubdir=$AlignmentPrefix"/"
ReferenceIndex="${ReferenceInputFile/.fasta/.mmi}"
AlignmentBam=$OutputSubdir$AlignmentPrefix.bam

mkdir $OutputSubdir

# Make reference file
minimap2 -d $ReferenceIndex $ReferenceInputFile

# Do Alignment with Minimap.
# Pipe alignment into "samtools view" to convert to bam.
# Pipe into "samtools sort" to sort I guess.
# note: minimap2, and samtools operations can accept a # of threads to use.
# the -m option is for filtering smaller alignments. 
# Default of 40 allows for lots of crappy misaligned reads. I think around half the length of the reference might be good.
# From the minimap2 man page:
# -m INT	
# Discard chains with chaining score <INT [40]. 
# Chaining score equals the approximate number of matching bases minus a concave gap penalty. 
minimap2 -ax map-ont -m $MinimumReadSize $ReferenceIndex $ReadInputFile | samtools view -b | samtools sort -o $AlignmentBam

# Index the alignment for viewing
samtools index $AlignmentBam

# You can view with IGV

