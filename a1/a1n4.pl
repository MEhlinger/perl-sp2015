#!usr/bin/perl

print "\nEnter tele number as xxx-xxx-xxxx:  ";

chomp($input = <STDIN>);

if ($input =~ /\d\d\d-\d\d\d-\d\d\d\d/) {
	print "\nValid.\n";
} else {
	print "\nInvalid\n";
}
