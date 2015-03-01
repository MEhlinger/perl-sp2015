#!/usr/bin/perl
# a6n2.pl by Marshall Ehlinger
# call as perl a6n2.pl a6n2.txt

use warnings;
use strict;

my @data = <>;
$_ = join '', @data; # Note: with default variable, don't use "my"

while ( /(\d{3}-\d{3}-\d{4})/g) {
  print "found $1\n";
}
