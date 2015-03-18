#!/usr/bin/perl
# Call as perl a4n7.pl a4n7.txt
#use strict;
use warnings;

my %ages; # Hash dictionary of values

while (chomp(my $lines = <>)) {
  $ages{$lines}+= 1;
}



foreach my $key  (sort {$ages{$a} <=> $ages{$b} } keys %ages) {
	printf "%5d : %5d\n", $key , $ages{$key};
}
