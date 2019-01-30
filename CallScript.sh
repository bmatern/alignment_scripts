#cd "/MinIONData/2019.DRA.2ndRoundBasecalling/1D2_Demultiplexed/Run_4/"
#-r = Reference File
#-R = Read File
#-n = Alignment Name
#-m = Minimum Read Size

bash MinION_Minimap_Alignment.sh \
-r "/MinIONData/2019.DRA.2ndRoundBasecalling/1D2_Demultiplexed/Run_4/AlignmentReference.fasta" \
-R "/MinIONData/2019.DRA.2ndRoundBasecalling/1D2_Demultiplexed/Run_4/BC01.fastq" \
-n "BC01_1D2_Alignment" \
-m "3000" \
