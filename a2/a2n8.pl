#!/usr/bin/perl -w

use warnings;
use strict;

my @one;
my @two;

for ( my $i = 1 ; $i < 21 ; $i++ ) {
    if ( $i % 2 == 0 ) {
        push @one, $i;
    }
    else {
        push @two, $i;
    }
}

print "ONE: @one \nTWO: @two\n";

my @three = ();
push @three, @one, @two;
print "COMBINED UNSORTED: @three\n";

for ( my $i = 0 ; $i < 20 ; $i++ ) {
    for ( my $j = 0 ; $j < 20 ; $j++) {
        while ( $three[$i] > $three[$j] ) {
            ( $three[$i], $three[$j] ) = ( $three[$j], $three[$i] );
        }
        while ( $three[$i] < $three[$j]) {
            ( $three[$i], $three[$j] ) = ( $three[$j], $three[$i] );
        }
    }
}

print "Sorted: @three\n";
