
conda activate homer
cd /data2/yudonglin/hic_analysis_new

## step 1 : makeTagDir
tagdir=/data2/yudonglin/hic_analysis_new/tagDir
makeTagDirectory ${tagdir}/MOCK -format HiCsummary MOCK.allValidPairs.homer
## step 2 : calculate PC1 value
output=/data2/yudonglin/hic_analysis_new/compartment/
runHiCpca.pl ${output}MOCK-500k ${tagdir}/MOCK -cpu 40 -res 500000  -genome /data/yudonglin/reference/human/hg19/hg19.fa -pc 1 
## output data,两个output




conda activate homer
cd /data2/yudonglin/hic_analysis_new

## step 1 : makeTagDir
tagdir=/data2/yudonglin/hic_analysis_new/tagDir
makeTagDirectory ${tagdir}/EV68 -format HiCsummary EV68.allValidPairs.homer
## step 2 : calculate PC1 value
output=/data2/yudonglin/hic_analysis_new/compartment/
runHiCpca.pl ${output}EV68-500k ${tagdir}/EV68 -cpu 20 -res 500000  -genome /data/yudonglin/reference/human/hg19/hg19.fa -pc 1 
## output data,两个output





conda activate homer
cd /data2/yudonglin/hic_analysis_new

## step 1 : makeTagDir
tagdir=/data2/yudonglin/hic_analysis_new/tagDir
makeTagDirectory ${tagdir}/EV71 -format HiCsummary EV71.allValidPairs.homer
## step 2 : calculate PC1 value
output=/data2/yudonglin/hic_analysis_new/compartment/
runHiCpca.pl ${output}EV71-500k ${tagdir}/EV71 -cpu 20 -res 500000  -genome /data/yudonglin/reference/human/hg19/hg19.fa -pc 1 
## output data,两个output



