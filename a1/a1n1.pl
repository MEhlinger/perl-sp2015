#!/usr/bin/perl

print "\nEnter telephone number as xxx-xxx-xxxx: ";

chomp ($input = <STDIN>);

if ($input =~ /\d\d\d-\d\d\d-\d\d\d\d/) {
	print "\n Valid Number";
} else {
	print "\n Invalid Number";
}

