#!usr/bin/perl -w
open IN,"<chr$ARGV[0].snp" or die "cannot open the file $!";
%hash=();
while(<IN>)
{
    chomp;
    @tmp=split/\s+/,$_;
    $hash{$tmp[4]}=1; #print "$tmp[0].done\n$tmp[1].done\n$tmp[2].done\n$tmp[3].done\n"; exit 0;
}
close IN;
open FI,"<../rufipogon" or die "$!";
%wide=();
while(<FI>)
{
    chomp;
    $wide{$_}=1;
}
close FI;
open FI2,"<../indica" or die "$!";
%indica=();
while(<FI2>)
{
    chomp;
    $indica{$_}=1;
}
close FI2;
open SNP,"<chr$ARGV[0].maf.vcf" or die "cannot open the file $!";
open OUT1,">chr$ARGV[0].wide.geno" or die "$!";
open OUT2,">chr$ARGV[0].indica.geno" or die "$!";
@list2=();@list3=();
while(<SNP>)
{
    if($_=~/^#CHROM/)
    {
        chomp;
        @array=split("\t",$_);
        foreach $i(9..$#array)
        {
            if(exists $wide{$array[$i]})
            {
                push @list2,$i;
            }
            if(exists $indica{$array[$i]})
            {
                push @list3,$i;
            }
        }
    }
    if($_=~/^chr/)
    {
        chomp;
        @tmp=split("\t",$_);
        if(exists $hash{$tmp[1]})
        {
            foreach $n(0..$#list2-1)
            {
                if($tmp[$list2[$n]]=~/\.\/\./)
                {
                    print OUT1 "9 9 ";
                }
                else
                {
                    @crray=split/\/|:/,$tmp[$list2[$n]];
                    print OUT1 "$crray[0] $crray[1] ";
                }
            }
            if($tmp[$list2[-1]]=~/\.\/\./)
            {
                print OUT1 "9 9\n";
            }
            else
            {
                @crray=split/\/|:/,$tmp[$list2[-1]];
                print OUT1 "$crray[0] $crray[1]\n";
            }
            foreach $n(0..$#list3-1)
            {
                if($tmp[$list3[$n]]=~/\.\/\./)
                {
                    print OUT2 "9 9 ";
                }
                else
                {
                    @crray=split/\/|:/,$tmp[$list3[$n]];
                    print OUT2 "$crray[0] $crray[1] ";
                }
            }
            if($tmp[$list3[-1]]=~/\.\/\./)
            {
                print OUT2 "9 9\n";
            }
            else
            {
                @crray=split/\/|:/,$tmp[$list3[-1]];
                print OUT2 "$crray[0] $crray[1]\n";
            }
        }
    }
}
close SNP;
close OUT1;
close OUT2;
