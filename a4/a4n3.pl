#!/usr/bin/perl

use strict;
use warnings;

while (my $line = <>) {
	if ($line =~ /c99:{1}\s+\d{2}[.\s]*/) {
		print "$line \n";
	}
}

print "\nEOF\n\n";
