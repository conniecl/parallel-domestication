#!usr/bin/perl -w
open LI,"</public/home/lchen/zeamap/07.para/msu_v6.1/IRGSP-1.0_2019-06-26/all_gene.sort.pos "or die "cannot open the file $!";
while(<LI>)
{
    if($_=~/^\d/)
    {
        chomp;
        @tmp=split/\s+/,$_;
        push @data,$tmp[3];
    }
}
close LI;
for(1..1000)
{
    %hash=();
    while((keys %hash)<$ARGV[0])
    {
        $hash{int(rand($#data+1))}=1;
    }
    open OUT,">kegg_rand/rand.$_" or die "Cannot open the file $!";
    foreach (keys %hash)
    {
        print OUT "$data[$_]\n";
    }
    close OUT;
}
