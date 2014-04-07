#! /usr/bin/perl -w

use strict;
my (@date,@time,@x,@y,@z);

while (<>) {
  chomp;
  if (/when/) {
    $_ =~ s/<when>//;
    $_ =~ s/<\/when>//;
    my @split = split(/T/,$_);
    die "When line doesn't give date and time" if @split != 2;
    my ($date,$time) = @split;
    push @date, $date;
    push @time, $time;
    #print "$date and $time\n";
  } elsif (/coord/) {
    $_ =~ s/<gx:coord>//;
    $_ =~ s/<\/gx:coord>//;
    my @split = split;
    die "coord line doesn't give x y z" if @split != 3;
    my ($x,$y,$z) = @split;
    #print "$x $y $z\n";
    push @x, $x;
    push @y, $y;
    push @z, $z;
  }
}

die "Number of coordinates don't match up to number of timestamps" unless (scalar(@x) == scalar(@time));


print "{\n\"type\": \"FeatureCollection\",\n\"features\": [\n";
print "{\n\"type\": \"Feature\",\n\"properties\": {},\n\"geometry\": "; 

# Print MultiPoint GeoJSON
#print "{\n\"type\": \"MultiPoint\",\n\"coordinates\": [\n";

# Print LineString GeoJSON
print "{\n\"type\": \"LineString\",\n\"coordinates\": [\n";

for (my $ii = 0; $ii <= $#x; $ii ++) {
  if ($ii == 0) {
    print "[\n$x[$ii],\n$y[$ii]\n]";
  } else {
    print ",\n[\n$x[$ii],\n$y[$ii]\n]\n";
  }
}

print "]\n}\n";
print "}\n";
print "]\n}\n";
