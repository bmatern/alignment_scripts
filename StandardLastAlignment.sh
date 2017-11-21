# Set some variables.

ReferenceInputFile="Reference.fasta"
ReadInputFile="Reads.fastq"
AlignmentPrefix="all_read_alignment"
OutputSubdir=$AlignmentPrefix"/"

# Last Aligner will require different arg/parameters, 
# if reads are either .fasta or .fastq
# -Q is the input format.  0=fasta, 1=fastq-sanger, etc...
FastaArgs="-s 2 -T 0 -Q 0 -a 1"
FastqArgs="-s 2 -T 0 -Q 1 -a 1"

#LastalCommandlineArgs=$FastaArgs
LastalCommandlineArgs=$FastqArgs

mkdir $OutputSubdir


# Make FASTQ file from directory of FAST5 files
# poretools documentation website: http://poretools.readthedocs.org/en/latest/
# poretools fastq pass/*.fast5 >Burn-In_Perth_pass.fastq

# Make reference file
lastdb -Q 0 $OutputSubdir$AlignmentPrefix.lastindex $ReferenceInputFile

# Do Alignment
lastal $LastalCommandlineArgs $OutputSubdir$AlignmentPrefix.lastindex $ReadInputFile | /usr/bin/last-map-probs > $OutputSubdir$AlignmentPrefix.last.txt

# Convert alignment to Sam
/usr/bin/maf-convert sam $OutputSubdir$AlignmentPrefix.last.txt > $OutputSubdir$AlignmentPrefix.last.sam

# Sort the alignment
samtools view -T $ReferenceInputFile -bS $OutputSubdir$AlignmentPrefix.last.sam | samtools sort - $OutputSubdir$AlignmentPrefix.last.sorted

# Index the alignment for viewing
samtools index $OutputSubdir$AlignmentPrefix.last.sorted.bam

# You can view with IGV

