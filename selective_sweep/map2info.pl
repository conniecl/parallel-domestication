open IN,"<$ARGV[0].map" or die "cannot open the file $!";
open OUT,">$ARGV[0]_haploview.info" or die "cannot open the file $!";
$i=1;
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    print OUT "marker$i\t$tmp[-1]\n";
    $i++;
}
close IN;
close OUT;
