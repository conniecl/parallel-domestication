#!usr/bin/perl -w
open IN,"<./$ARGV[0].$ARGV[1]_haploview.info" or die "cannot open the file $!";
open OUT,">$ARGV[1]_split/$ARGV[0].info.0" or die "cannot open the file $!";
%hash=();$flag=0;%count=();
open $fh{0},">$ARGV[1]_split/$ARGV[0].ped.0" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $inter=int($tmp[1]/500000);
    if($flag!=$inter)
    {
        open OUT,">$ARGV[1]_split/$ARGV[0].info.$inter" or die "cannot open the file $!";
        print OUT "$_\n";
        $count{$inter}=1;
        if(exists $hash{$inter})
        {
            #print "$tmp[0]\t";
            $hash{$inter}+=$hash{$flag};
            $hash{$inter}+=2;
            $flag=$inter;
            
            
        }
        else
        {
            #print "$tmp[0]\t$flag\t$inter\n";
            foreach $k($flag+1..$inter)
            {
                $hash{$k}=$hash{$flag};
            }
            $hash{$inter}+=2;
            $flag=$inter;
            #print OUT "$_\n";
        }
    }
    else
    {
        $hash{$inter}+=2;
        print OUT "$_\n";
    }
}
close IN;
close OUT;
foreach $v(keys %count)
{
    open $fh{$v},">$ARGV[1]_split/$ARGV[0].ped.$v" or die "cannot open the file $!";
}
open LI,"<./$ARGV[0].$ARGV[1]_haploview.ped" or die "cannot open the file $!";
@sub=keys %hash;
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    $fh{0}->print( "$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]\t" );
    foreach $v(1..$hash{0}-1)
    {
        $fh{0}->print("$tmp[$v+5]\t");
    }
    $fh{0}->print("$tmp[5+$hash{0}]\n");
    foreach $i(1..$#sub)
    {
	if(exists $fh{$i})
        {
            $fh{$i}->print( "$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]\t" );
            foreach $j($hash{$i-1}+1..$hash{$i}-1)
            {
                $fh{$i}->print ("$tmp[5+$j]\t");
            }
            $fh{$i}->print ("$tmp[5+$hash{$i}]\n")
        }
        
        
    }
}
close LI;
