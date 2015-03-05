#!/usr/bin/perl

# a6n11.pl by Marshall Ehlinger
# call as : perl a6n11.pl WORD
# Searches for all words followed by period, counts frequency of each, then  
# For debugging, uses walden.txt

use warnings;
use strict;

open(my $fh, "walden.txt") or die "cannot open $!";
my @book = <$fh>;
my $book = join "", @book;

my %freq = ();
while ($book =~ /\s(\w+)./g) {
	my $word = lc $1;
	$freq{$word}++;
}

foreach my $wordKey ( sort{$freq{$a} <=> $freq{$b}} keys %freq) {
	print "$wordKey : $freq{$wordKey}\n";
}
