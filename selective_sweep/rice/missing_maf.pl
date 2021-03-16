#!usr/bin/perl -w
use List::Util qw/min/;
@file=qw/indica rufipogon/;
foreach $in(@file)
{
    open LI,"</public/home/lchen/zeamap/07.para/xpclr_subnew/$in" or die "$!";
    while(<LI>)
    {
        chomp;
        $hash{$_}=$in;
    }
    close LI;
}
if($ARGV[0]<10)
{
    open IN,"gzip -dc /public/home/lchen/zeamap/07.para/xpclr_new/ld/chr0$ARGV[0].vcf.gz|" or die "$!";
}
else
{
    open IN,"gzip -dc /public/home/lchen/zeamap/07.para/xpclr_new/ld/chr$ARGV[0].vcf.gz|" or die "$!";
}
open OUT,">chr$ARGV[0].maf.vcf" or die "$!";
print OUT "##fileformat=VCFv4.2\n";
print OUT "##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">\n";
while(<IN>)
{
    if($_=~/^#CHROM/)
    {
        chomp;
        @array=split("\t",$_);
        foreach $m(0..$#array-1)
        {
            print OUT "$array[$m]\t";
        }
        print OUT "$array[-1]\n";
    }
    if($_=~/^chr/)
    {
        chomp;
        %sum=();$flag=0;%maf=();%miss=();%total=();
        @tmp=split("\t",$_);
        foreach $i(9..$#tmp)
        {
            if(exists $hash{$array[$i]})
            {
                if($tmp[$i]!~/^\.\/\./)
                {
                    @brray=split/\//,$tmp[$i];
                    $maf{$hash{$array[$i]}}{$brray[0]}+=1;
                    $maf{$hash{$array[$i]}}{$brray[1]}+=1;
                    $sum{$hash{$array[$i]}}+=2;
                }
                else
                {
                    $miss{$hash{$array[$i]}}+=1;
                }
                $total{$hash{$array[$i]}}+=1;
            }
            
        }
        $min=1;
        foreach $key1(keys %maf)
        {
            @brray=keys %{$maf{$key1}};
            if($#brray>0|| $brray[0]!=0)
            {
                foreach $key2(keys %{$maf{$key1}})
                {
                    $rate=$maf{$key1}{$key2}/$sum{$key1};
                    if($rate<$min)
                    {
                        $min=$rate;
                    }
                }
                if($min<0.05)
                {
                    $flag=1;
                }
            }
            else
            {
                $flag=1;
            }
        }
        foreach $key3(keys %miss)
        {
            $missing=$miss{$key3}/$total{$key3};
            if($missing>0.75)
            {
                $flag=1;
            }
        }
        if($flag!=1)
        {
            foreach $n(0..$#tmp-1)
            {
                print OUT "$tmp[$n]\t";
            }
            print OUT "$tmp[-1]\n";
        }
    }
}
close IN;
close OUT;
