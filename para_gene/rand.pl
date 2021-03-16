#!usr/bin/perl -w
open IN,"</public/home/lchen/zeamap/07.para/msu_v6.1/IRGSP-1.0_2019-06-26/all_gene.sort.pos" or die "$!";
@data=();
while(<IN>)
{
    #if($_=~/^>/)
    #{
        chomp;
        @tmp=split("\t",$_);
        push @data,$tmp[-1];
    #}
}
close IN;
open LI,"</public/home/lchen/130/maize/lchen/v4_gff/Zea_mays.AGPv4.36.gene" or die "$!";
@file=();
while(<LI>)
{
    #if($_=~/^>/)
    #{
        chomp;
        @tmp=split("\t",$_);
        push @file,$tmp[-1];
    #}
}
close LI;
foreach $num(1..1000)
{
    %maize=();
    %hash=();
    while((keys %hash)<$ARGV[0])
    {
        $rand=int(rand($#data+1));
        $hash{$data[$rand]}=1;
    }
    while((keys %maize)<1929)
    {
	$rand=int(rand($#file+1));
        $maize{$file[$rand]}=1;
    }
    open OR,"</public/home/lchen/zeamap/07.para/msu_v6.1/rice_maize.rbh" or die "$!";
    open OUT,">rice_maize.$num" or die "$!";
    while(<OR>)
    {
        chomp;
        @tmp=split("\t",$_);
        $m=(split("_",$tmp[0]))[0];
        $tmp[1]=~s/t/g/;
        $o=(split("-",$tmp[1]))[0];
        if(exists $maize{$m} && exists $hash{$o})
        {
            print OUT "$_\n";
        }
    }
    close OR;
    close OUT;
}
