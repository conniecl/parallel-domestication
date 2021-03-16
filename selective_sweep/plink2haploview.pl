#!usr/bin/perl -w
open IN,"<$ARGV[0].ped" or die "cannot open the file $!";
open OUT,">$ARGV[0]_haploview.ped" or die "cannot open the file $!";
%hash=("0"=>0,"A"=>1,"C"=>2,"G"=>3,"T"=>4);
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    foreach $i(0..5)
    {
        print OUT "$tmp[$i]\t";
    }
    foreach $i(6..$#tmp-1)
    {
        print OUT "$hash{$tmp[$i]}\t";
    }
    print OUT "$hash{$tmp[$#tmp]}\n";
}
close IN;
close OUT;
