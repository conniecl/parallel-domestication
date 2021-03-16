#!usr/bin/perl -w
open IN,"</public/home/lchen/zeamap/07.para/msu_v6.1/maize_update/Zea_mays.gene.pathway" or die "$!";
%hash=();
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_,3);
    if($tmp[0] ne "-")
    {
        $hash{$tmp[0]}=$tmp[2];
        #print "$tmp[2]\n"; exit 0;
    }
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
            @array=split/\t|;/,$hash{$_};
            foreach $v(@array)
            {
                $rand{$v}{$i}+=1;
            }
        }
    }
    close RAND;
}
open LI,"<par.gene.ko" or die "$!";
%observe=();
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_,3);
    $observe{$tmp[0]}=$tmp[1];
    $count{$tmp[0]}=$tmp[2];
}
close LI;
open OUT,">par_pathway.pvalue" or die "$!";
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
