#!usr/bin/perl -w
open IN,"<$ARGV[0].gene" or die "$!";
%hash=();
while(<IN>)
{
    chomp;
    $hash{$_}=1;
}
close IN;
open OR,"<../../msu_v6.1/rice_maize.rbh" or die "$!";
while(<OR>)
{
    chomp;
    @tmp=split("\t",$_);
    $maize=(split("_",$tmp[0]))[0];
    $rice=(split("-",$tmp[1]))[0];
    $rice=~s/t/g/;
    $orth{$rice}=$maize;
}
close OR;
open RI,"</public/home/lchen/zeamap/06.select/par/par_overlap.50k.merge.gene" or die "$!";
while(<RI>)
{
    chomp;
    @tmp=split("\t",$_);
    $maize_s{$tmp[3]}=1;
}
close RI;
open LI,"<../../msu_v6.1/kegg/rice.gene.pathway" or die "$!";
%count=();%total=();
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if(exists $hash{$tmp[0]})
    {
        $count{$tmp[1]}+=1;
        if(exists $orth{$tmp[0]})
        {
            $count_o{$tmp[1]}+=1;
            if(exists $maize_s{$orth{$tmp[0]}})
            {
                $count_os{$tmp[1]}+=1;
            }
        }
    }
    $total{$tmp[1]}+=1;
}
close LI;
open OUT,">$ARGV[0].gene.ko" or die "$!";
foreach $key(keys %count)
{
    print OUT "$key\t$count{$key}\t";
    if(exists $count_o{$key})
    {
        print OUT "$count_o{$key}\t";
    }
    else
    {
        print OUT "0\t";
    }
    if(exists $count_os{$key})
    {
        print OUT "$count_os{$key}\t";
    }
    else
    {
        print OUT "0\t";
    }
    $rate=$count{$key}/$total{$key};
    print OUT "$rate\n";
}
close OUT;

