#!/usr/bin/perl
# Takes log.sql and returns busiest day
# Output is poorly formatted but probably not wrong! Sorry.

use warnings;
use strict;

open (my $fh, "/home/public/log.sql") or die "could not open log.sql";

my %count = ();

while (<$fh>) {
  chomp;
  if (/,\d{4}(\d\d\d\d)/) {
    $count{$1}++;
  }
}

my $maxVal = 0;
my $maxKey;

foreach my $key (keys %count) {
  if ($count{$key} > $maxVal) {
    $maxVal = $count{$key};
    $maxKey = $key;
  }
}


my $activeDay = $maxKey;

print "Busiest day was $activeDay\n\n";
