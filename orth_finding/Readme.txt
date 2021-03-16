### Main steps for identification orthologous genes in maize and rice
```
perl max_pep_rice.pl
perl max_pep_maize.pl
/public/home/lchen/software/ncbi-blast-2.8.1+/bin/blastp -query /public/home/lchen/130/maize/lchen/v4_gff/B73.max.pep.fa -out maize_rice.blastp -db ./IRGSP -evalue 1e-100 -outfmt 6 -num_threads 20
~/software/ncbi-blast-2.8.1+/bin/blastn -query /public/home/lchen/130/maize/lchen/teo_184/44.rice_selective/gff_RAP2/all_predict_gene.fa -out rap2_irgsp1.blastn -db ./irgsp_gene -outfmt 6 -max_target_seqs 1 -num_threads 30
perl find_rbh.pl
```
