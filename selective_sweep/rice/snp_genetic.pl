#!usr/bin/perl -w
open IN,"</public/home/lchen/zeamap/07.para/msu_v6.1/genetic_map.combine" or die "cannot open the file $!";
readline IN;
@pos=();@dis=();
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[1]==$ARGV[0])
    {
        push @pos,$tmp[-2];
        push @pos,$tmp[-1];
        push @dis,$tmp[5];
        push @dis,$tmp[5];
    }
}
close IN;
open LI,"<chr$ARGV[0].maf.vcf" or die "cannot open the file $!";
open OUT,">chr$ARGV[0].snp" or die "cannot open the file $!";
$flag=1;
while(<LI>)
{
    if($_!~/^#/)
    {
        chomp;
        @tmp=split("\t",$_,6);
        if(length($tmp[4])==1)
        {
            foreach $i(0..$#pos-1)
            {
                if($tmp[1]>=$pos[$i] && $tmp[1]<$pos[$i+1])
                {
                    $rate=($dis[$i+1]-$dis[$i])/($pos[$i+1]-$pos[$i]);
                    $gen=($tmp[1]-$pos[$i])*$rate+$dis[$i];
                    $gen=$gen/100;
                    print OUT " snp$flag\t$tmp[0]\t$gen\t$tmp[1]\t$tmp[3]\t$tmp[4]\n";
                }
            }
            if($tmp[1]>$pos[-1])
            {
                $gen=($tmp[1]-$pos[-1])*$rate+$dis[-1];
                $gen=$gen/100;
                print OUT " snp$flag\t$tmp[0]\t$gen\t$tmp[1]\t$tmp[3]\t$tmp[4]\n";
            }
            if($tmp[1]==$pos[-1])
            {
                $gen=$dis[-1]/100;
                print OUT " snp$flag\t$tmp[0]\t$gen\t$tmp[1]\t$tmp[3]\t$tmp[4]\n";
            }
            $flag++;
        }
    }
}
close LI;
close OUT;
