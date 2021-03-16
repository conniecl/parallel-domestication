python ~/software/anaconda2/bin/CrossMap.py bed AGPv2_to_AGPv4.chain.gz TEO_B73_linkagemap.v2 TEO_B73_linkagemap.v4
/public/home/lchen/software/vcftools-0.1.16/bin/vcftools --gzvcf /public/home/lchen/zeamap/01.data/final_vcf/merge_${chr}_filter.vcf.gz --keep ./par --out ./merge_$chr.par --recode --recode-INFO-all ## $chr=1,2,3...10
perl plink2haploview.pl $chr.par
perl map2info.pl $chr.par
perl 500k_haploview.pl $chr par
java -jar -Xmx50g /public/home/lchen/software/haplowiew/Haploview.jar -memory 51200 -n -pedfile $chr.par_haploview.ped -info $chr.par_haploview.info -log $chr.par.log -minMAF 0.05 -hwcutoff 0 -missingCutoff 0.5 -dprime -out ./$chr.par
perl gain_lsf.pl par
/public/home/lchen/software/XPCLR/bin/XPCLR -xpclr chr$i.amp.geno chr$i.par.geno1 chr$i.snp chr$i.1k -w1 0.005 100 1000 $i -p0 0.7 ##$i=1,2,3,4..10
cat chr1.1k.xpclr.txt chr2.1k.xpclr.txt chr3.1k.xpclr.txt chr4.1k.xpclr.txt chr5.1k.xpclr.txt chr6.1k.xpclr.txt chr7.1k.xpclr.txt chr8.1k.xpclr.txt chr9.1k.xpclr.txt chr10.1k.xpclr.txt >par_1k.xpclr
~/software/bedtools2/bin/bedtools subtract -a par_1k.xpclr -b ../par_mask.sort >par_1k.xpclr.mask ##remove the centrometers and inersion
perl top10_xpclr.pl par
/public/home/lchen/software/vcftools-0.1.16/bin/vcftools --vcf ../merge_${i}_filter.vcf --keep /public/home/lchen/zeamap/05.ld/new/maize --window-pi 2000 --window-pi-step 1000 --out chr$i.maize.2k
/public/home/lchen/software/vcftools-0.1.16/bin/vcftools --vcf ../merge_${i}_filter.vcf --keep /public/home/lchen/zeamap/05.ld/new/par --window-pi 2000 --window-pi-step 1000 --out chr$i.par.2k
perl pi_divide.pl par
perl top10_pi.pl par
~/software/bedtools2/bin/bedtools intersect -wa -u -a par.top10.xpclr -b ../../01.data/final_vcf/pi/par.2k.top10.pi >par_overlap.bed
cut -f 1,2,3 par_overlap.bed >par_overlap.region
~/software/bedtools2/bin/bedtools merge -d 1 -i par_overlap.region >par_overlap.merge.bed
perl merge_10k.pl 5
~/software/bedtools2/bin/bedtools intersect -wa -wb -a ~/ref/Zea_mays.AGPv4.36.gene -b par_overlap.50k.merge.bed >par_overlap.50k.merge.gene
