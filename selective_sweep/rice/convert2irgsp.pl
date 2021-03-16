#!usr/bin/perl -w
open IN,"<../msu_v6.1/rap2_irgsp1.id.covert" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_,3);
    $hash{$tmp[0]}=$tmp[1];
}
close IN;
open LI,"<$ARGV[0]_selective.gene" or die "$!";
open OUT,">$ARGV[0]_selective.irgsp.gene" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if(exists $hash{$tmp[3]})
    {
        print OUT "$_\t$hash{$tmp[3]}\n";
    }
}
close LI;
close OUT;
