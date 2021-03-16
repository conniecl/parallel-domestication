#!usr/bin/perl -w
open IN,"<par_overlap.50k.merge.gene" or die "$!";
%hash=();
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $hash{$tmp[3]}=1;
}
close IN;
open LI,"</public/home/lchen/zeamap/07.para/msu_v6.1/maize_update/Zea_mays.gene.pathway" or die "$!";
%count=();%total=();
while(<LI>)
{
    if($_!~/^-/)
    {
        chomp;
        @tmp=split/\t|;/,$_;
        if(exists $hash{$tmp[0]})
        {
            foreach $v(2..$#tmp)
            {
                $count{$tmp[$v]}+=1;
            }
        }
        foreach $k(2..$#tmp)
        {
            $total{$tmp[$k]}+=1;
        }
    }
}
close LI;
open OUT,">par.gene.ko" or die "$!";
foreach $key(keys %count)
{
    print OUT "$key\t$count{$key}\t";
    $rate=$count{$key}/$total{$key};
    print OUT "$rate\n";
}
close OUT;
