#https://www.ncbi.nlm.nih.gov/nuccore/NC_038308.1?report=fasta
cd /data/yudonglin/reference/virus/ev68
hisat2-build -p 100 ev68.fa ev68


#EV68的比对：
cd /data/yudonglin/data/RNAseq
conda activate rnaseq
for i in {RD-EV68-24h-1,RD-EV68-24h-2,RD-EV71-24h-1,RD-EV71-24h-2,RD-MOCK-1,RD-MOCK-2};
do 
#cutadapt --pair-filter=any --minimum-length 15 --max-n 8 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT -o ./clean/${i}_rmadp_1.fq.gz -p ./clean/${i}_rmadp_2.fq.gz ${i}_R1.fq.gz ${i}_R2.fq.gz >>filter.txt 2>&1
#trimmomatic PE -threads 40 -phred33 ./clean/${i}_rmadp_1.fq.gz ./clean/${i}_rmadp_2.fq.gz -baseout ./clean/${i}_fliter.fq.gz  AVGQUAL:20 SLIDINGWINDOW:4:15 MINLEN:15 1>>filter.txt 2>&1;
hisat2 --threads 35 -x /data/yudonglin/reference/virus/ev68/ev68 -1 ./clean/${i}_fliter_1P.fq.gz -2 ./clean/${i}_fliter_2P.fq.gz -S ${i}.sam;
#samtools view -S ${i}.sam -b > ${i}.bam;
#rm ./hisat/${i}.sam;
#samtools sort ./hisat/${i}.bam -o ./hisat/${i}_sorted.bam;
#samtools index ./hisat/${i}_sorted.bam;
#featureCounts -T 30 -t exon -g gene_id -a /data/yudonglin/reference/human/hg19/Homo_sapiens.GRCh37.75.gtf -o ./count/${i}.count ./hisat/${i}_sorted.bam >>~/count.txt 2>&1
#bamCoverage --bam ./hisat/${i}_sorted.bam -o ./hisat/${i}_sorted.bam.bw  --binSize 10 -p 40
#rm ./hisat/${i}.bam;
done


conda activate rnaseq
cd /data3/yudonglin/hic/RNAseq/rawdata
for i in {RD-MOCK-1,RD-EV68-24h-2,RD-EV71-24h-2};
do 
#cutadapt --pair-filter=any --minimum-length 15 --max-n 8 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT -o ./clean/${i}_rmadp_1.fq.gz -p ./clean/${i}_rmadp_2.fq.gz ${i}_R1.fq.gz ${i}_R2.fq.gz >>filter.txt 2>&1
#trimmomatic PE -threads 40 -phred33 ./clean/${i}_rmadp_1.fq.gz ./clean/${i}_rmadp_2.fq.gz -baseout ./clean/${i}_fliter.fq.gz  AVGQUAL:20 SLIDINGWINDOW:4:15 MINLEN:15 1>>filter.txt 2>&1;
hisat2 --threads 35 -x /data/yudonglin/reference/virus/ev68/ev68 -1 ./clean/${i}_fliter_1P.fq.gz -2 ./clean/${i}_fliter_2P.fq.gz -S ${i}.sam;
#samtools view -S ${i}.sam -b > ${i}.bam;
#rm ./hisat/${i}.sam;
#samtools sort ./hisat/${i}.bam -o ./hisat/${i}_sorted.bam;
#samtools index ./hisat/${i}_sorted.bam;
#featureCounts -T 30 -t exon -g gene_id -a /data/yudonglin/reference/human/hg19/Homo_sapiens.GRCh37.75.gtf -o ./count/${i}.count ./hisat/${i}_sorted.bam >>~/count.txt 2>&1
#bamCoverage --bam ./hisat/${i}_sorted.bam -o ./hisat/${i}_sorted.bam.bw  --binSize 10 -p 40
#rm ./hisat/${i}.bam;
done


#https://www.ncbi.nlm.nih.gov/nuccore/EU703814.1?report=fasta
conda activate rnaseq
cd /data/yudonglin/reference/virus/ev71
hisat2-build -p 100 ev71.fa ev71



#EV71的比对：
cd /data/yudonglin/data/RNAseq
conda activate rnaseq
for i in {RD-EV68-24h-1,RD-EV68-24h-2,RD-EV71-24h-1,RD-EV71-24h-2,RD-MOCK-1,RD-MOCK-2};
do 
#cutadapt --pair-filter=any --minimum-length 15 --max-n 8 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT -o ./clean/${i}_rmadp_1.fq.gz -p ./clean/${i}_rmadp_2.fq.gz ${i}_R1.fq.gz ${i}_R2.fq.gz >>filter.txt 2>&1
#trimmomatic PE -threads 40 -phred33 ./clean/${i}_rmadp_1.fq.gz ./clean/${i}_rmadp_2.fq.gz -baseout ./clean/${i}_fliter.fq.gz  AVGQUAL:20 SLIDINGWINDOW:4:15 MINLEN:15 1>>filter.txt 2>&1;
hisat2 --threads 35 -x /data/yudonglin/reference/virus/ev71/ev71 -1 ./clean/${i}_fliter_1P.fq.gz -2 ./clean/${i}_fliter_2P.fq.gz -S ${i}_ev71.sam;
#samtools view -S ${i}.sam -b > ${i}.bam;
#rm ./hisat/${i}.sam;
#samtools sort ./hisat/${i}.bam -o ./hisat/${i}_sorted.bam;
#samtools index ./hisat/${i}_sorted.bam;
#featureCounts -T 30 -t exon -g gene_id -a /data/yudonglin/reference/human/hg19/Homo_sapiens.GRCh37.75.gtf -o ./count/${i}.count ./hisat/${i}_sorted.bam >>~/count.txt 2>&1
#bamCoverage --bam ./hisat/${i}_sorted.bam -o ./hisat/${i}_sorted.bam.bw  --binSize 10 -p 40
#rm ./hisat/${i}.bam;
done


conda activate rnaseq
cd /data3/yudonglin/hic/RNAseq/rawdata
for i in {RD-MOCK-1,RD-EV68-24h-2,RD-EV71-24h-2};
do 
#cutadapt --pair-filter=any --minimum-length 15 --max-n 8 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT -o ./clean/${i}_rmadp_1.fq.gz -p ./clean/${i}_rmadp_2.fq.gz ${i}_R1.fq.gz ${i}_R2.fq.gz >>filter.txt 2>&1
#trimmomatic PE -threads 40 -phred33 ./clean/${i}_rmadp_1.fq.gz ./clean/${i}_rmadp_2.fq.gz -baseout ./clean/${i}_fliter.fq.gz  AVGQUAL:20 SLIDINGWINDOW:4:15 MINLEN:15 1>>filter.txt 2>&1;
hisat2 --threads 35 -x /data/yudonglin/reference/virus/ev71/ev71 -1 ./clean/${i}_fliter_1P.fq.gz -2 ./clean/${i}_fliter_2P.fq.gz -S ${i}_ev71.sam;
#samtools view -S ${i}.sam -b > ${i}.bam;
#rm ./hisat/${i}.sam;
#samtools sort ./hisat/${i}.bam -o ./hisat/${i}_sorted.bam;
#samtools index ./hisat/${i}_sorted.bam;
#featureCounts -T 30 -t exon -g gene_id -a /data/yudonglin/reference/human/hg19/Homo_sapiens.GRCh37.75.gtf -o ./count/${i}.count ./hisat/${i}_sorted.bam >>~/count.txt 2>&1
#bamCoverage --bam ./hisat/${i}_sorted.bam -o ./hisat/${i}_sorted.bam.bw  --binSize 10 -p 40
#rm ./hisat/${i}.bam;
done





