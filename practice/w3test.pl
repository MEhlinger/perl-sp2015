#!/usr/bin/perl
# w3test.pl by Marshall Ehlinger / John Phillips on 2/3/2915
# test of perltidy

use strict;
use warnings;

my @a = ( 60, 70, 80, 90, 100 );

my $sum = 0;
foreach my $num (@a) {
    $sum += $num;
}

my $avg = $sum / $#a;

print "Sum= $sum\n";
print "Avg = $avg\n";

# formatted in vim using perltidy
# :%!perltidy -q
