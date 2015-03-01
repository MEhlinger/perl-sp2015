#!/usr/bin/perl

# a4n4.pl by Marshall Ehlinger
# process auth.log file
# call as: perl a4n4.pl /home/public/auth.log

use warnings;
use strict;
my $count = 0;
my %iphash = ();

while (my $row = <>) {
	chomp $row;
	if ($row =~ /(\d+\.\d+\.\d+\.\d+)/) {
		$iphash{$1}++;
	}
	$count++;
}
foreach my $key  (sort {$iphash{$a} <=> $iphash{$b} } keys %iphash) {
	printf "%15s : %5d\n", $key , $iphash{$key};
}

print "Total lines in file / entry attempts: $count\n";
