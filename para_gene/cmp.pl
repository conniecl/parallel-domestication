#!usr/bin/perl -w
open IN,"<../$ARGV[0].maize.para" or die "$!";
$count=0;
while(<IN>)
{
    $count++;
}
close IN;
open OUT,">$ARGV[0].cmp" or die "$!";
print OUT "depression\tenrich\n";
$max=0;$min=0;
foreach $i(1..1000)
{
    $sum=0;
    open LI,"<rice_maize.$i" or die "$!";
    while(<LI>)
    {
        $sum++;
    }
    close LI;
    if($sum>$count)
    {
        $max++;
    }
    if($sum<$count)
    {
        $min++;
    }
}
print OUT "$max\t$min\n";
