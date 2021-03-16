#!usr/bin/perl -w
%maize=();
open FA2,"</public/home/lchen/130/maize/lchen/v4_gff/B73.max.pep.fa" or die "$!";
while(<FA2>)
{
    chomp;
    if($_=~/^>/)
    {
        s/>//g;
        $id=$_;
    }
    else
    {
        $maize{$id}.=$_;
    }
}
close FA2;
open FA1,"<IRGSP.max.pep.fa" or die "$!";
%hash=();
while(<FA1>)
{
    chomp;
    if($_=~/^>/)
    {
        s/>//g;
        $id=$_; #print "$id\n"; exit 0;
    }
    else
    {
        $hash{$id}.=$_;
    }
}
close FA1;
%count=();%best=();
open IN1,"<rice_maize.blastp" or die "$!";
while(<IN1>)
{
    chomp;
    @array=split("\t",$_);
    if(!exists $count{$array[0]})
    {
        if($hash{$array[0]}=~/\*$/)
        {
            $cov=($array[7]-$array[6]+1)/(length($hash{$array[0]})-1);
        }
        else
        {
            $cov=($array[7]-$array[6]+1)/length($hash{$array[0]});
        }
        if($cov>=0.7)
        {
            $best{$array[1]}{$array[0]}=1; 
        }
    }
    $count{$array[0]}=1;
}
close IN1;
open IN2,"<maize_rice.blastp" or die "$!";
open OUT,">rice_maize.rbh" or die "$!";
%count=();
while(<IN2>)
{
    chomp;
    @array=split("\t",$_);
    if(!exists $count{$array[0]})
    {
        if($maize{$array[0]}=~/\*$/)
        {
            $cov=($array[7]-$array[6]+1)/(length($maize{$array[0]})-1);
        }
        else
        {
            $cov=($array[7]-$array[6]+1)/length($maize{$array[0]});
        }
        if($cov>=0.7 && exists $best{$array[0]}{$array[1]})
        {
            print OUT "$array[0]\t$array[1]\n";
        }
	$count{$array[0]}=1;
    }
}
close IN2;
close OUT;
