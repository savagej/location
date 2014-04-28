#! /usr/bin/perl -w

use strict;
my (@date,@time,@x,@y,@z);

open (my $json, ">", "output.json");
open (my $txt , ">", "output.txt");

while (<>) {
  chomp;
  if (/when/) {
    $_ =~ s/<when>//;
    $_ =~ s/<\/when>//;
    my @split = split(/T/,$_);
    die "When line doesn't give date and time" if @split != 2;
    my ($date,$time) = @split;
    $time = substr $time , 0 , -6; # removes -07:00 from end of time
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


print $json "{\n\"type\": \"FeatureCollection\",\n\"features\": [\n";
print $json "{\n\"type\": \"Feature\",\n\"properties\": {},\n\"geometry\": "; 

# Print MultiPoint GeoJSON
#print $json "{\n\"type\": \"MultiPoint\",\n\"coordinates\": [\n";

# Print LineString GeoJSON
print $json "{\n\"type\": \"LineString\",\n\"coordinates\": [\n";

for (my $ii = 0; $ii <= $#x; $ii ++) {
  if ($ii == 0) {
    print $txt "$date[$ii] $time[$ii] $x[$ii] $y[$ii]\n";
    print $json "[\n$x[$ii],\n$y[$ii]\n]";
  } else {
    print $txt "$date[$ii] $time[$ii] $x[$ii] $y[$ii]\n";
    print $json ",\n[\n$x[$ii],\n$y[$ii]\n]\n";
  }
}

print $json "]\n}\n";
print $json "}\n";
print $json "]\n}\n";
