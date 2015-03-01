#!/usr/bin/perl
# a6n6.pl by Marshall Ehlinger
# processes /home/public/log.sql
# ISSUE: the whole middle block about undefined values = 0 shouldn't be necessary-- script is adding some frequencies multiple times?

use strict;
use warnings;

open (my $fh, "/home/public/log.sql") or die "could not open log.sql";
my %freq = ();

while (<$fh>) {
  chomp;
  if (/,(\d+),.*'i'/) {
    $freq{$1}++;
  }
}


foreach my $studentId (%freq) {
  if (!$freq{$studentId}) {
    $freq{$studentId} = 0;
  }
}

foreach my $studentId (sort {$a <=> $b} values %freq) {
  print "$studentId : $freq{$studentId}\n";
}

