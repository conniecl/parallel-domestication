# Main steps for identification orthologous genes in maize and rice
```
perl max_pep_rice.pl
perl max_pep_maize.pl
/public/home/lchen/software/ncbi-blast-2.8.1+/bin/makeblastdb -in B73.max.pep.fa -dbtype prot -parse_seqids -out B73.max
/public/home/lchen/software/ncbi-blast-2.8.1+/bin/makeblastdb -in IRGSP.max.pep.fa -dbtype prot -parse_seqids -out IRGSP
/public/home/lchen/software/ncbi-blast-2.8.1+/bin/blastp -query ./IRGSP.max.pep.fa -out rice_maize.blastp -db /public/home/lchen/130/maize/lchen/v4_gff/B73.max -evalue 1e-100 -outfmt 6 -num_threads 10
/public/home/lchen/software/ncbi-blast-2.8.1+/bin/blastp -query /public/home/lchen/130/maize/lchen/v4_gff/B73.max.pep.fa -out maize_rice.blastp -db ./IRGSP -evalue 1e-100 -outfmt 6
perl find_rbh.pl
```
