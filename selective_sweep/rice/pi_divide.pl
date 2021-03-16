#!usr/bin/perl -w
open IN1,"<rufipogon_rmmix.20k.windowed.pi" or die "cannot open the file $!";
open IN2,"<$ARGV[0]_rmmix.20k.windowed.pi" or die "cannot open the file $!";
readline IN1;
readline IN2;
while(<IN1>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[3]>=50)
    {
        $hash{$tmp[0]}{$tmp[1]}=$tmp[-1];
    }
}
close IN1;
open OUT,">rufipogon_divide_$ARGV[0].20k.pi" or die "cannot open the file $!";
while(<IN2>)
{
    chomp;
    @tmp=split("\t",$_);
    $end=$tmp[1]+19999;
    if(exists $hash{$tmp[0]}{$tmp[1]} && $tmp[3]>=50)
    {
        $v=$hash{$tmp[0]}{$tmp[1]}/$tmp[-1];
        print OUT "$tmp[0]\t$tmp[1]\t$end\t$v\n";
    }
    else
    {
        print OUT "$tmp[0]\t$tmp[1]\t$end\tNA\n";
    }
}
close IN2;
close OUT;
