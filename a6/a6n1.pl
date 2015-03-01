#!/usr/bin/perl
# a6n1.pl by Marshall Ehlinger on 3/1/2014
# call as perl a6n1.pl a6n1.txt

use strict;
use warnings;

my $name;
my $city;

while (<>) {
  if (/^(\w+),.*?, (\w.+?), \w\w\s*(\d{5})$/) {
    $name = $1;
    $city = $2;
    print "$name lives in $city\n";
  }
}
