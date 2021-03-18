# Selective sweeps calculated in that study
## change chr1 to chr2,3,4...12; change indica to japonica, sativa
```bash
/public/home/lchen/software/anaconda2/bin/python /public/home/lchen/software/anaconda2/bin/CrossMap.py bed MSU6_to_IRGSP-1.0.chain.gz genetic_map.s.bed genetic_map.irgsp1.s
/public/home/lchen/software/anaconda2/bin/python /public/home/lchen/software/anaconda2/bin/CrossMap.py bed MSU6_to_IRGSP-1.0.chain.gz genetic_map.e.bed genetic_map.irgsp1.e
perl snp_genetic.pl 1
perl geno.pl 1
/public/home/lchen/software/XPCLR/bin/XPCLR -xpclr chr1.indica.geno chr1.wide.geno chr1.snp chr1.indica.10k -w1 0.0002 400 10000 1 -p0 0.7
perl top10_xpclr.pl
/public/home/lchen/software/vcftools-0.1.16/bin/vcftools --gzvcf ../../xpclr_new/SNP_filter2_final_gt2.vcf.gz --keep /public/home/lchen/zeamap/07.para/xpclr_subnew/rufipogon --window-pi 20000 --window-pi-step 10000 --out rufipogon_rmmix.20k
/public/home/lchen/software/vcftools-0.1.16/bin/vcftools --gzvcf ../../xpclr_new/SNP_filter2_final_gt2.vcf.gz --keep /public/home/lchen/zeamap/07.para/xpclr_subnew/indica --window-pi 20000 --window-pi-step 10000 --out indica_rmmix.20k
perl pi_divide.pl indica
perl top10_pi.pl indica 
~/software/bedtools2/bin/bedtools intersect -wa -u -a indica.top10.xpclr -b indica.20k.top10.pi >indica_overlap.bed
~/software/bedtools2/bin/bedtools merge -d 1 -i indica_overlap.bed >indica_overlap.merge.bed
~/software/bedtools2/bin/bedtools intersect -wa -wb -a ../../msu_v6.1/IRGSP-1.0_2019-06-26/all_gene.sort.pos -b indica_overlap.merge.score >indica_overlap.merge.gene
```
## combine the genes
```bash
cat sativa_overlap.merge.bed indica_overlap.merge.bed japonica_overlap.merge.bed |sort -k1,1g -k2,2g >all_overlap.bed
cat indica.gene japonica.gene sativa.gene |sort|uniq >all.gene
```

# Selective sweeps from Huang et al. 2012.
## change indica to japonica, sativa
```bash
~/software/ncbi-blast-2.8.1+/bin/makeblastdb -in IRGSP-1.0_gene_2019-06-26.fasta -dbtype nucl -out irgsp_gene
~/software/ncbi-blast-2.8.1+/bin/blastn -query /public/home/lchen/130/maize/lchen/teo_184/44.rice_selective/gff_RAP2/all_predict_gene.fa -out rap2_irgsp1.blastn -db ./irgsp_gene -outfmt 6 -max_target_seqs 1 -num_threads 30
perl blast_id.pl
~/software/bedtools2/bin/bedtools intersect -wa -wb -a ./all_predict_gene.sort.bed -b indica_selective.bed >indica_selective.gene
perl convert2irgsp.pl indica
```
## combine the genes
```bash
cat indica.gene japonica.gene sativa.gene |sort|uniq >all.gene
```

# kegg enrichment analysis
```bash
cat ../huang/sativa.gene ../tian_intersect/sativa.gene |sort|uniq >sativa.gene
cat ../huang/indica.gene ../tian_intersect/indica.gene |sort|uniq >indica.gene
cat ../huang/japonica.gene ../tian_intersect/japonica.gene |sort|uniq >japonica.gene
cat ../huang/all.gene ../tian_intersect/all.gene |sort|uniq >all.gene
perl ko_anno_sub.pl indica
perl ko_anno_sub.pl japonica
perl ko_anno_sub.pl sativa
perl ko_anno_sub.pl all
perl kegg_rand/rand_gene.pl 2743
perl kegg_pvalue_sub.pl indica
for i in {1..1000};do rm kegg_rand/rand.$i;done
perl kegg_rand/rand_gene.pl 3785
perl kegg_pvalue_sub.pl japonica
for i in {1..1000};do rm kegg_rand/rand.$i;done
perl kegg_rand/rand_gene.pl 1914
perl kegg_pvalue_sub.pl sativa
for i in {1..1000};do rm kegg_rand/rand.$i;done
cat sativa.gene indica.gene japonica.gene |sort|uniq >all.gene
perl ko_anno_sub.pl all
perl kegg_rand/rand_gene.pl 6847
perl kegg_pvalue_sub.pl all
for i in {1..1000};do rm kegg_rand/rand.$i;done
```
