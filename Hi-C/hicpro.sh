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
