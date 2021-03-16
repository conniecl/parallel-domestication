#!usr/bin/perl -w
open IN,"<../../msu_v6.1/kegg/rice.gene.pathway" or die "$!";
%hash=();
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    push @{$hash{$tmp[0]}},$tmp[1];
}
close IN;
%rand=();
foreach $i(1..1000)
{
    open RAND,"<kegg_rand/rand.$i" or die "$!";
    while(<RAND>)
    {
        chomp;
        if(exists $hash{$_})
        {
            foreach $v(@{$hash{$_}})
            {
                $rand{$v}{$i}+=1;
            }
        }
    }
    close RAND;
}
open LI,"<$ARGV[0].gene.ko" or die "$!";
%observe=();
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_,3);
    $observe{$tmp[0]}=$tmp[1];
    $count{$tmp[0]}=$tmp[2];
}
close LI;
open OUT,">$ARGV[0]_pathway.pvalue" or die "$!";
print OUT "pathway\tpvalue\tgene_num\n" or die "$!";
foreach $key(keys %observe)
{
    $undetect=0;$up=0;
    if(exists $rand{$key})
    {
        $undetect=1000-scalar(keys %{$rand{$key}});
        foreach $key2(keys %{$rand{$key}})
        {
            if($observe{$key}>$rand{$key}{$key2})
            {
                $up++;
            }
        }
    }
    $rate=(1000-($up+$undetect))/1000;
    print OUT "$key\t$rate\t$observe{$key}\t$count{$key}\n";
}
close OUT;
