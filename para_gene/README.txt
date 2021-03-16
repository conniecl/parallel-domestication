## change indica to sativa, japonica, all
perl para.pl indica
/public/home/lchen/software/ncbi-blast-2.8.1+/bin/blastp -query /public/home/lchen/130/maize/lchen/v4_gff/B73.max.pep.fa -out maize_rice.blast -db ../IRGSP -evalue 1e-10 -num_alignments 5 -outfmt 6 -num_threads 20
~/130/lchen/software/MCScanX/MCScanX ./maize_rice
perl col.pl indica
## enrichment analysis
perl rand.pl 2743
perl cmp.pl indica
perl static.pl indica
for i in {1..1000};do rm rice_maize.$i;done
perl rand.pl 3785
perl cmp.pl japonica
perl static.pl japonica
for i in {1..1000};do rm rice_maize.$i;done
perl rand.pl 1914
perl cmp.pl sativa
perl static.pl sativa
for i in {1..1000};do rm rice_maize.$i;done
perl rand.pl 6847
perl cmp.pl all
perl static.pl all
for i in {1..1000};do rm rice_maize.$i;done
