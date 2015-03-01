#!usr/bin/perl

use strict;
use warnings;

my %e2s = ();

#Read in the translation dictionary into hash
open my $fh, "a4n6.txt" or die "could not open file\n";
while (my $line = <$fh>) {
	chomp $line;
	( my $eng, my $spa ) = split( ':', $line);
	$e2s{$eng} = $spa;
}

print "Enter an English sentence to translate: ";
chomp (my $sentence = <STDIN>);

my @sentenceWords = split('\s+', $sentence);

foreach my $word (@sentenceWords) {
	if ( defined( $e2s{$word} )) {
		print $e2s{$word} . ' ';
	} else {
		print '[' . $word . '] ';
	}
}
print "\n";
