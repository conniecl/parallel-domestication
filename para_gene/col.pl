#!usr/bin/perl -w
open IN,"<$ARGV[0].maize.para" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $hash{$tmp[0]}{$tmp[1]}=1;
}
close IN;
open LI,"</public/home/lchen/zeamap/07.para/msu_v6.1/mcscan/maize_rice.collinearity" or die "$!";
open OUT,">$ARGV[0].maize.para.col" or die "$!";
while(<LI>)
{
    if($_!~/^#/)
    {
        chomp;
        @tmp=split/\s+/,$_;
        foreach $i(0..$#tmp)
        {
            if($tmp[$i]=~/^Os/)
            {
                @array=split("-",$tmp[$i]);
                $array[0]=~s/t/g/;
            }
            if($tmp[$i]=~/^Zm/)
            {
                @brray=split("_P",$tmp[$i]);
            }
        }
        if(exists $hash{$brray[0]}{$array[0]})
        {
            print OUT "$brray[0]\t$array[0]\n";
        }
    }
}
close LI;
close OUT;
