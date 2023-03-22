



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

