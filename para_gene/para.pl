#!usr/bin/perl -w
open IN,"<$ARGV[0].gene" or die "$!";
while(<IN>)
{
    chomp;
    $rice{$_}=1;
}
close IN;
open IN1,"<../par/par_overlap.50k.merge.gene" or die "$!";
while(<IN1>)
{
    chomp;
    @tmp=split("\t",$_);
    $maize{$tmp[3]}=1;
}
close IN1;
open LI,"<../../msu_v6.1/rice_maize.rbh" or die "$!";
open OUT,">$ARGV[0].maize.para" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    @array=split("\_P",$tmp[0]);
    @brray=split("-",$tmp[1]);
    $brray[0]=~tr/t/g/;
    #print "$array[0]\n$brray[0]\n"; exit 0;
    if(exists $maize{$array[0]} && exists $rice{$brray[0]})
    {
        print OUT "$array[0]\t$brray[0]\n";
    }
}
close LI;
close OUT;
