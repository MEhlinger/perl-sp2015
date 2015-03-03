#!/usr/bin/perl

# a6n10.pl by Marshall Ehlinger
# call as : perl a6n10.pl WORD
# Searches text file for word, counts occurances ignoring case and punctuation
# For debugging, uses, hardcoded, walden.txt

use warnings;
use strict;

open(my $fh, "walden.txt") or die "cannot open $!";
my @book = <$fh>;
my $book = join "", @book;

my %freq = ();
while ($book =~ /\b([a-zA-Z'-]+)\b/migs) {
	my $word = lc $1;
	$freq{$word}++;
}


foreach my $wordKey ( sort{$freq{$a} <=> $freq{$b}} keys %freq) {
	print "$wordKey : $freq{$wordKey}\n";
}
