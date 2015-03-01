#!usr/bin/perl

print "Enter two sides of triangle to calculate hypoteneuse.";
print "\nEnter first side of triangle: ";
chomp($a = <STDIN>);
print "\nEnter second side of triangle: ";
chomp($b = <STDIN>);
$c = $a**2 + $b**2;
print "\nHypoteneuse is $c.\n";
