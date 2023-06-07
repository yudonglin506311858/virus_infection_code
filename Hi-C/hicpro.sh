
conda activate HiC-Pro_v3.1.0

/data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -h


修改特定设置：

必备文件1-基因组bowtie2索引
必备文件2-酶切片段文件
必备文件3-genome size文件


python  /data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/utils/digest_genome.py /data/yudonglin/reference/human/hg19/hg19.fa -r HindIII -o /data/yudonglin/reference/human/hg19/hg19_HindIII.bed

python  /data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/utils/digest_genome.py /data/yudonglin/reference/human/hg19/hg19.fa -r DPNII -o /data/yudonglin/reference/human/hg19/hg19_DPNII.bed


#获取genome size 文件
samtools faidx /data/yudonglin/reference/human/hg19/hg19.fa
awk '{print $1 "\t" $2}' /data/yudonglin/reference/human/hg19/hg19.fa.fai > /data/yudonglin/reference/human/hg19/hg19.sizes


#运行HiC-Pro
/data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -c /data/yudonglin/software/hicpro/HiC-Pro/CONFIG-HICPRO.txt -o analysis -i data

nohup /data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -c /data/yudonglin/software/hicpro/HiC-Pro/CONFIG-HICPRO.txt -o analysis -i clean &

cd /data/yudonglin/data/HiC/Rawdata
#mkdir clean
#数据过滤：
trim_galore --cores 30 -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data/yudonglin/data/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_2.fq.gz --gzip -o ./clean
trim_galore --cores 30  -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data/yudonglin/data/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_2.fq.gz --gzip -o ./clean
trim_galore  --cores 30 -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data/yudonglin/data/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_2.fq.gz --gzip -o ./clean



cd /data/yudonglin/data/HiC/Rawdata
nohup trim_galore --cores 30 -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data/yudonglin/data/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_2.fq.gz --gzip -o ./clean &
nohup trim_galore --cores 30  -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data/yudonglin/data/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_2.fq.gz --gzip -o ./clean &
nohup trim_galore  --cores 30 -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data/yudonglin/data/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_2.fq.gz --gzip -o ./clean &



conda activate HiC-Pro_v3.1.0

/data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -h

nohup /data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -c /data/yudonglin/software/hicpro/HiC-Pro/CONFIG-HICPRO.txt -o analysis -i clean &





#数据合并：
zcat /data3/yudonglin/hic/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_1.fq.gz >>2-RD-MOCK_1.fq
zcat /data3/yudonglin/hic/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_2.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-MOCK/2-RD-MOCK_2.fq.gz >>2-RD-MOCK_2.fq


zcat /data3/yudonglin/hic/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_1.fq.gz >>2-RD-EV68-24h_1.fq
zcat /data3/yudonglin/hic/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_2.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV68-24h/2-RD-EV68-24h_2.fq.gz >>2-RD-EV68-24h_2.fq


zcat /data3/yudonglin/hic/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_1.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_1.fq.gz >>2-RD-EV71-24h_1.fq
zcat /data3/yudonglin/hic/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_2.fq.gz /data/yudonglin/data/HiC/Rawdata/2-RD-EV71-24h/2-RD-EV71-24h_2.fq.gz >>2-RD-EV71-24h_2.fq

gzip *.fq



cd /data3/yudonglin/hic/HiC/merge
mkdir clean
#数据过滤：
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data3/yudonglin/hic/HiC/merge/2-RD-MOCK/2-RD-MOCK_1.fq.gz /data3/yudonglin/hic/HiC/merge/2-RD-MOCK/2-RD-MOCK_2.fq.gz --gzip -o ./clean -j 20
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data3/yudonglin/hic/HiC/merge/2-RD-EV68-24h/2-RD-EV68-24h_1.fq.gz /data3/yudonglin/hic/HiC/merge/2-RD-EV68-24h/2-RD-EV68-24h_2.fq.gz --gzip -o ./clean -j 20
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired /data3/yudonglin/hic/HiC/merge/2-RD-EV71-24h/2-RD-EV71-24h_1.fq.gz /data3/yudonglin/hic/HiC/merge/2-RD-EV71-24h/2-RD-EV71-24h_2.fq.gz --gzip -o ./clean -j 20


cd /data2/yudonglin
conda activate HiC-Pro_v3.1.0
ulimit -n 655350
nohup /data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -c /data/yudonglin/software/hicpro/HiC-Pro/CONFIG-HICPRO.txt -o /data2/yudonglin/hic_analysis_new -i /data3/yudonglin/hic/HiC/merge/clean &


#重新修改bin
cd /data4/yudonglin
conda activate HiC-Pro_v3.1.0
ulimit -n 655350
nohup /data/yudonglin/software/hicpro/HiC-Pro/HiC-Pro_3.1.1/bin/HiC-Pro -c /data/yudonglin/software/hicpro/HiC-Pro/CONFIG-HICPRO_new.txt -o /data4/yudonglin/hic_analysis_new -i /data3/yudonglin/hic/HiC/merge/clean &








