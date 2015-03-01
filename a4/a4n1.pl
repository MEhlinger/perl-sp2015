#!/usr/bin/perl

use strict;
use warnings;

my $input = ''; # temporary input
my @nums = (); # array of numbers
my %freq = (); # hash of number frequencies
my $count = 0; # count of numbers
my $sum = 0; # sum of numbers
my $avg = 0; # average
my $med = 0; #median
my $maxspace = 0; # max space for histogram

while ($input = <>) {
    if ($input eq '') {
        last;
    }

    push @nums, $input;
    $freq{$input}++;
    $count++;
    $sum += $input;
}

@nums = sort {$a <=> $b} @nums;
$avg = $sum / $count;
$med = $nums[$count / 2];

print "\nTotal count of numbers: $count\n";
print "Total sum of numbers: $sum\n";
print "Minimum number: $nums[0]\n";
print "Maximum number: $nums[$#nums]\n";
printf ("Average (mean): %.2f\n", $avg);
print "Median: $med\n\n";
print "Frequency of Values:\n";

$maxspace = (length $nums[$#nums]) + 1;

foreach my $key (sort {$a <=> $b} keys %freq) {
    print $key;
    print ' ' x ($maxspace - length $key);
    print '| ', '*' x $freq{$key}, "\n";
}

