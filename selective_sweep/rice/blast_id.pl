#!usr/bin/perl -w
open IN1,"</public/home/lchen/130/maize/lchen/teo_184/44.rice_selective/gff_RAP2/all_predict_gene.fa" or die "$!";
while(<IN1>)
{
    chomp;
    if($_=~/^>/)
    {
        s/>//g;
        $id=$_;
    }
    else
    {
        $fa1{$id}.=$_;
    }
}
close IN1;
open IN2,"<IRGSP-1.0_gene_2019-06-26.fasta" or die "$!";
while(<IN2>)
{
    chomp;
    if($_=~/^>/)
    {
        s/>//g;
        $id=(split/\s+/,$_)[0];
    }
    else
    {
        $fa2{$id}.=$_;
    }
}
close IN2;
open LI,"<rap2_irgsp1.blastn" or die "$!";
open OUT,">rap2_irgsp1.id.covert" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[2]>=80)
    {
        $cov1=abs(($tmp[7]-$tmp[6])/length($fa1{$tmp[0]}));
        $cov2=abs(($tmp[9]-$tmp[8])/length($fa2{$tmp[1]}));
        $tmp[1]=~s/t/g/;
        $name=(split/-/,$tmp[1])[0];
        if($cov1>=0.8 && $cov2>=0.8)
        {
            if($tmp[0] eq $name)
            {
                print OUT "$tmp[0]\t$name\t$tmp[2]\t$cov1\t$cov2\tsame\n";
            }
            else
            {
                $chr1=$tmp[0];
                $chr1=~/Os(\d\d)g/;
                $chr1=$1;
                $chr2=$name;
                $chr2=~/Os(\d\d)g/;
                $chr2=$1;
                if($chr1 eq $chr2)
                {
                    print OUT "$tmp[0]\t$name\t$tmp[2]\t$cov1\t$cov2\tdiff\n";
                }
            }
        }
    }
}
close LI;
close OUT;
