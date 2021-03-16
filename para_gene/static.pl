#!usr/bin/perl -w
use List::Util qw/sum/;
open OUT,">$ARGV[0].static" or die "$!";
@list=();
foreach $j(1..1000)
{
    open IN,"<rice_maize.$j" or die "$!";
    $count=0;
    while(<IN>)
    {
        $count++;
    }
    close IN;
    push @list,$count;
}
$avg=sum(@list)/1000;
$sum=0;
foreach $v(@list)
{
    $sum+=(($v-$avg)*($v-$avg));
}
$sd=sqrt($count/1000);
print OUT "$ARGV[0]\t$sd\t$avg\trand\n";
close OUT;
