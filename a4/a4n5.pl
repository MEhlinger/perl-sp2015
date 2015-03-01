#!/usr/bin/perl
# a4n5.pl by Marshall Ehlinger

use warnings;
use strict;

my $filename = '/etc/passwd';
open (my $fh, $filename) or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
	if ($row =~ /^(\w+):x:(\d\d\d\d):/) {
		printf("%17s : %4d\n", $1, $2);
	}
}
