cd /data/yudonglin/data/ChIPseq



ls *.gz | while read id
do
file=$(basename $id) #basename是提取文件名，也就是把前面那些路径去掉
sample=${file%%.*}  #%%这个符号是去掉后缀的意思。
echo $sample
done


#质控：
fastqc *.gz


mkdir clean
#数据过滤：
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 1-mock-K27-1_R1.fq.gz 1-mock-K27-1_R2.fq.gz --gzip -o ./clean
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 1-mock-K27-2_R1.fq.gz 1-mock-K27-2_R2.fq.gz --gzip -o ./clean
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 2-EV68--K27-1_R1.fq.gz 2-EV68--K27-1_R2.fq.gz --gzip -o ./clean
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 2-EV68--K27-2_R1.fq.gz 2-EV68--K27-2_R2.fq.gz --gzip -o ./clean
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 3-EV71--K27-1_R1.fq.gz 3-EV71--K27-1_R2.fq.gz --gzip -o ./clean
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 3-EV71--K27-2_R1.fq.gz 3-EV71--K27-2_R2.fq.gz --gzip -o ./clean

#https://www.jianshu.com/p/7a3de6b8e503


mkdir bowtie2
#比对到基因组
bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/1-mock-K27-1_R1_val_1.fq.gz -2 ./clean/1-mock-K27-1_R2_val_2.fq.gz -S ./bowtie2/mock1_trimmed.sam

bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/1-mock-K27-2_R1_val_1.fq.gz -2 ./clean/1-mock-K27-2_R2_val_2.fq.gz -S ./bowtie2/mock2_trimmed.sam

bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/2-EV68--K27-1_R1_val_1.fq.gz -2 ./clean/2-EV68--K27-1_R2_val_2.fq.gz -S ./bowtie2/EV68_1_trimmed.sam

bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/2-EV68--K27-2_R1_val_1.fq.gz -2 ./clean/2-EV68--K27-2_R2_val_2.fq.gz -S ./bowtie2/EV68_2_trimmed.sam

bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/3-EV71--K27-1_R1_val_1.fq.gz -2 ./clean/3-EV71--K27-1_R2_val_2.fq.gz -S ./bowtie2/EV71_1_trimmed.sam

bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/3-EV71--K27-2_R1_val_1.fq.gz -2 ./clean/3-EV71--K27-2_R2_val_2.fq.gz -S ./bowtie2/EV71_2_trimmed.sam



#sam转换为bam文件
grep -v "XS:i:" ./bowtie2/mock1_trimmed.sam |samtools view -bS - >./bowtie2/mock1_trimmed.bam
grep -v "XS:i:" ./bowtie2/mock2_trimmed.sam |samtools view -bS - >./bowtie2/mock2_trimmed.bam
grep -v "XS:i:" ./bowtie2/EV68_1_trimmed.sam |samtools view -bS - >./bowtie2/EV68_1_trimmed.bam
grep -v "XS:i:" ./bowtie2/EV68_2_trimmed.sam |samtools view -bS - >./bowtie2/EV68_2_trimmed.bam
grep -v "XS:i:" ./bowtie2/EV71_1_trimmed.sam |samtools view -bS - >./bowtie2/EV71_1_trimmed.bam
grep -v "XS:i:" ./bowtie2/EV71_2_trimmed.sam |samtools view -bS - >./bowtie2/EV71_2_trimmed.bam


#bam文件建立索引
samtools sort ./bowtie2/mock1_trimmed.bam -o ./bowtie2/mock1_trimmed_sorted.bam
samtools index ./bowtie2/mock1_trimmed_sorted.bam

samtools sort ./bowtie2/mock2_trimmed.bam -o ./bowtie2/mock2_trimmed_sorted.bam
samtools index ./bowtie2/mock2_trimmed_sorted.bam

samtools sort ./bowtie2/EV68_1_trimmed.bam -o ./bowtie2/EV68_1_trimmed_sorted.bam
samtools index ./bowtie2/EV68_1_trimmed_sorted.bam

samtools sort ./bowtie2/EV68_2_trimmed.bam -o ./bowtie2/EV68_2_trimmed_sorted.bam
samtools index ./bowtie2/EV68_2_trimmed_sorted.bam

samtools sort ./bowtie2/EV71_1_trimmed.bam -o ./bowtie2/EV71_1_trimmed_sorted.bam
samtools index ./bowtie2/EV71_1_trimmed_sorted.bam

samtools sort ./bowtie2/EV71_2_trimmed.bam -o ./bowtie2/EV71_2_trimmed_sorted.bam
samtools index ./bowtie2/EV71_2_trimmed_sorted.bam





#转换为bw文件
bamCoverage -b ./bowtie2/mock1_trimmed_sorted.bam -o ./bowtie2/mock1_trimmed_sorted.bam.bw -p 40

bamCoverage -b ./bowtie2/mock2_trimmed_sorted.bam -o ./bowtie2/mock2_trimmed_sorted.bam.bw -p 40

bamCoverage -b ./bowtie2/EV68_1_trimmed_sorted.bam -o ./bowtie2/EV68_1_trimmed_sorted.bam.bw -p 40

bamCoverage -b ./bowtie2/EV68_2_trimmed_sorted.bam -o ./bowtie2/EV68_2_trimmed_sorted.bam.bw -p 40

bamCoverage -b ./bowtie2/EV71_1_trimmed_sorted.bam -o ./bowtie2/EV71_1_trimmed_sorted.bam.bw -p 40

bamCoverage -b ./bowtie2/EV71_2_trimmed_sorted.bam -o ./bowtie2/EV71_2_trimmed_sorted.bam.bw -p 40



bamCoverage -b ./bowtie2/mock1_trimmed_sorted.bam -o ./bowtie2/mock1_trimmed_sorted_rpkm.bam.bw -p 40 --binSize 10 --normalizeUsing RPKM




#安装参考基因组
perl /home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/share/homer/configureHomer.pl -install mm10
perl /home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/share/homer/configureHomer.pl -install hg19


cd /data/yudonglin/data/ChIPseq/bowtie2

#call peak
macs2 callpeak -t EV68_1_trimmed_sorted.bam EV68_2_trimmed_sorted.bam -c mock1_trimmed_sorted.bam mock2_trimmed_sorted.bam -f BAM -g hs -n EV68 -B -q 0.01 --nomodel --extsize 113
macs2 callpeak -t EV71_1_trimmed_sorted.bam EV71_2_trimmed_sorted.bam -c mock1_trimmed_sorted.bam mock2_trimmed_sorted.bam -f BAM -g hs -n EV71 -B -q 0.01 --nomodel --extsize 113



#寻找motif
/home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/share/homer/findMotifsGenome.pl EV68_summits.bed hg19 ./EV68_motif -S 25 -len 8,10,12,13 -size 400
/home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/share/homer/findMotifsGenome.pl EV71_summits.bed hg19 ./EV71_motif -S 25 -len 8,10,12,13 -size 400



/home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/share/homer/findMotifsGenome.pl EV68_peaks.narrowPeak hg19 ./EV68_motif -S 25 -len 8,10,12,13 -size 400
/home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/share/homer/findMotifsGenome.pl EV71_peaks.narrowPeak hg19 ./EV71_motif -S 25 -len 8,10,12,13 -size 400



/home/yudonglin/miniconda3/bin/findMotifsGenome.pl EV68_peaks.narrowPeak hg19 ./EV68_motif -S 25 -len 8,10,12,13 -size 400
/home/yudonglin/miniconda3/bin/findMotifsGenome.pl EV71_peaks.narrowPeak hg19 ./EV71_motif -S 25 -len 8,10,12,13 -size 400



cd /data/yudonglin/data/ChIPseq/bowtie2

/home/yudonglin/miniconda3/pkgs/homer-4.11-pl5321h9f5acd7_7/bin/findMotifsGenome.pl EV71_peaks.narrowPeak hg19 ./EV71_motif -S 25 -len 8,10,12,13 -size 400


-rw-rw-r-- 1 yudonglin yudonglin 110M Aug 17 04:29 EV68_1_trimmed_sorted.bam.bw
-rw-rw-r-- 1 yudonglin yudonglin 137M Aug 17 04:30 EV68_2_trimmed_sorted.bam.bw
-rw-rw-r-- 1 yudonglin yudonglin 104M Aug 17 04:31 EV71_1_trimmed_sorted.bam.bw
-rw-rw-r-- 1 yudonglin yudonglin 118M Aug 17 04:33 EV71_2_trimmed_sorted.bam.bw
-rw-rw-r-- 1 yudonglin yudonglin 103M Aug 17 04:26 mock1_trimmed_sorted.bam.bw
-rw-rw-r-- 1 yudonglin yudonglin 115M Aug 17 04:28 mock2_trimmed_sorted.bam.bw

computeMatrix reference-point -S EV68_1_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o EV68_1_trimmed_sorted.bam.bw.gz --outFileSortedRegions EV68_1_trimmed_sorted.bam.bw.bed -p 40


plotHeatmap -m EV68_1_trimmed_sorted.bam.bw.gz -out EV68_1_trimmed_sorted.pdf --samplesLabel "EV68-1"  --colorMap bwr 
plotProfile -m EV68_1_trimmed_sorted.bam.bw.gz -out profile_EV68_1.pdf --samplesLabel "EV68-1" 

computeMatrix reference-point -S EV68_2_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o EV68_2_trimmed_sorted.bam.bw.gz --outFileSortedRegions EV68_2_trimmed_sorted.bam.bw.bed -p 40


plotHeatmap -m EV68_2_trimmed_sorted.bam.bw.gz -out EV68_2_trimmed_sorted.pdf --samplesLabel "EV68-2"  --colorMap bwr 
plotProfile -m EV68_2_trimmed_sorted.bam.bw.gz -out profile_EV68_2.pdf --samplesLabel "EV68-2" 



computeMatrix reference-point -S EV71_1_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o EV71_1_trimmed_sorted.bam.bw.gz --outFileSortedRegions EV71_1_trimmed_sorted.bam.bw.bed -p 40


plotHeatmap -m EV71_1_trimmed_sorted.bam.bw.gz -out EV71_1_trimmed_sorted.pdf --samplesLabel "EV71-1"  --colorMap bwr 
plotProfile -m EV71_1_trimmed_sorted.bam.bw.gz -out profile_EV71_1.pdf --samplesLabel "EV71-1" 

computeMatrix reference-point -S EV71_2_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o EV71_2_trimmed_sorted.bam.bw.gz --outFileSortedRegions EV71_2_trimmed_sorted.bam.bw.bed -p 40


plotHeatmap -m EV71_2_trimmed_sorted.bam.bw.gz -out EV71_2_trimmed_sorted.pdf --samplesLabel "EV71-2"  --colorMap bwr 
plotProfile -m EV71_2_trimmed_sorted.bam.bw.gz -out profile_EV71_2.pdf --samplesLabel "EV71-2" 





computeMatrix reference-point -S mock1_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o mock_1_trimmed_sorted.bam.bw.gz --outFileSortedRegions mock_1_trimmed_sorted.bam.bw.bed -p 40
plotHeatmap -m mock_1_trimmed_sorted.bam.bw.gz -out mock_1_trimmed_sorted.pdf --samplesLabel "mock-1"  --colorMap bwr 
plotProfile -m mock_1_trimmed_sorted.bam.bw.gz -out profile_mock_1.pdf --samplesLabel "mock-1" 

computeMatrix reference-point -S mock2_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o mock_2_trimmed_sorted.bam.bw.gz --outFileSortedRegions mock_2_trimmed_sorted.bam.bw.bed -p 40
plotHeatmap -m mock_2_trimmed_sorted.bam.bw.gz -out mock_2_trimmed_sorted.pdf --samplesLabel "mock-2"  --colorMap bwr 
plotProfile -m mock_2_trimmed_sorted.bam.bw.gz -out profile_mock_2.pdf --samplesLabel "mock-2" 





computeMatrix reference-point -S mock1_trimmed_sorted.bam.bw  mock2_trimmed_sorted.bam.bw  EV68_1_trimmed_sorted.bam.bw EV68_2_trimmed_sorted.bam.bw EV71_1_trimmed_sorted.bam.bw EV71_2_trimmed_sorted.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv -a 3000 -b 3000 -o trimmed_sorted.bam.bw.gz --outFileSortedRegions trimmed_sorted.bam.bw.bed -p 40
plotHeatmap -m trimmed_sorted.bam.bw.gz -out trimmed_ALL.pdf --samplesLabel "mock-1" "mock-2"  "EV68-1"  "EV68-2" "EV71-1"  "EV71-2"  --colorMap bwr 
plotProfile -m trimmed_sorted.bam.bw.gz -out profile_ALL.pdf --samplesLabel "mock-1" "mock-2"  "EV68-1"  "EV68-2" "EV71-1"  "EV71-2"



computeMatrix scale-regions -S mock1_trimmed_sorted_rpkm.bam.bw -R /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv --beforeRegionStartLength 3000 --regionBodyLength 5000 --afterRegionStartLength 3000 --skipZeros -o mock1_matrix.mat.gz  -p 40


computeMatrix scale-regions -R  /data/yudonglin/reference/human/hg19/hg19_ucsc.tsv  \
                              -S   mock1_trimmed_sorted.bam.bw  mock2_trimmed_sorted.bam.bw  EV68_1_trimmed_sorted.bam.bw EV68_2_trimmed_sorted.bam.bw EV71_1_trimmed_sorted.bam.bw EV71_2_trimmed_sorted.bam.bw   --beforeRegionStartLength 3000 --regionBodyLength 5000 --afterRegionStartLength 3000 --skipZeros -o matrix_all.gz -p 50

plotHeatmap -m matrix_all.gz -out heatmap_all_TSS-TES.pdf --samplesLabel "mock-1" "mock-2"  "EV68-1"  "EV68-2" "EV71-1"  "EV71-2"  --colorMap bwr 
plotProfile -m matrix_all.gz -out profile_all_TSS-TES.pdf --samplesLabel "mock-1" "mock-2"  "EV68-1"  "EV68-2" "EV71-1"  "EV71-2"


#查看TSS附近信号强度：

#https://cloud.tencent.com/developer/article/1346037




#加测的数据：
conda activate rnaseq
cd /data3/yudonglin/hic/ChIPseq


#质控：
fastqc *.gz


mkdir clean
#数据过滤：
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 1-mock-K27-2_R1.fq.gz 1-mock-K27-2_R2.fq.gz --gzip -o ./clean -j 30
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 2-EV68--K27-2_R1.fq.gz 2-EV68--K27-2_R2.fq.gz --gzip -o ./clean -j 30
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired 3-EV71--K27-2_R1.fq.gz 3-EV71--K27-2_R2.fq.gz --gzip -o ./clean -j 30

#https://www.jianshu.com/p/7a3de6b8e503

mkdir bowtie2
#比对到基因组
bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/1-mock-K27-2_R1_val_1.fq.gz -2 ./clean/1-mock-K27-2_R2_val_2.fq.gz -S ./bowtie2/mock3_trimmed.sam
bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/2-EV68--K27-2_R1_val_1.fq.gz -2 ./clean/2-EV68--K27-2_R2_val_2.fq.gz -S ./bowtie2/EV68_3_trimmed.sam
bowtie2 -p 40 -x /data/yudonglin/reference/human/hg19/bowtie2/hg19 -1 ./clean/3-EV71--K27-2_R1_val_1.fq.gz -2 ./clean/3-EV71--K27-2_R2_val_2.fq.gz -S ./bowtie2/EV71_3_trimmed.sam



#sam转换为bam文件
grep -v "XS:i:" ./bowtie2/mock3_trimmed.sam |samtools view -bS - >./bowtie2/mock3_trimmed.bam -@ 50
grep -v "XS:i:" ./bowtie2/EV68_3_trimmed.sam |samtools view -bS - >./bowtie2/EV68_3_trimmed.bam -@ 50
grep -v "XS:i:" ./bowtie2/EV71_3_trimmed.sam |samtools view -bS - >./bowtie2/EV71_3_trimmed.bam -@ 50


#bam文件建立索引
samtools sort ./bowtie2/mock3_trimmed.bam -o ./bowtie2/mock3_trimmed_sorted.bam -@ 50
samtools index ./bowtie2/mock3_trimmed_sorted.bam
samtools sort ./bowtie2/EV68_3_trimmed.bam -o ./bowtie2/EV68_3_trimmed_sorted.bam -@ 50
samtools index ./bowtie2/EV68_3_trimmed_sorted.bam
samtools sort ./bowtie2/EV71_3_trimmed.bam -o ./bowtie2/EV71_3_trimmed_sorted.bam -@ 50
samtools index ./bowtie2/EV71_3_trimmed_sorted.bam


#转换为bw文件
bamCoverage -b ./bowtie2/mock3_trimmed_sorted.bam -o ./bowtie2/mock3_trimmed_sorted.bam.bw -p 40 --binSize 10 --normalizeUsing RPKM
bamCoverage -b ./bowtie2/EV68_3_trimmed_sorted.bam -o ./bowtie2/EV68_3_trimmed_sorted.bam.bw -p 40 --binSize 10 --normalizeUsing RPKM
bamCoverage -b ./bowtie2/EV71_3_trimmed_sorted.bam -o ./bowtie2/EV71_3_trimmed_sorted.bam.bw -p 40 --binSize 10 --normalizeUsing RPKM

