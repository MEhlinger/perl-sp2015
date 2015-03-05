#!/usr/bin/perl
# Processes cis3325.txt, a list of user emails, and outputs their usernames on ubuntu here from the first half of the username

use strict;
use warnings;

open(my $fh, "cis3325.txt") or die "I can't open cis3325.txt!";
my @docList = <$fh>;
my $doc = join "", @docList;

my @usernames;
while ($doc =~ /^(.*?)@/g) {
  push @usernames, $1;
}
while ($doc =~ /;(.*?)@/g) {
  push @usernames, $1;  
}

for (my $i = 0; $i < @usernames; $i++) {
  print "$usernames[$i]\n";
}
