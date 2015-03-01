#!usr/bin/perl -w

print "\nYou will need to enter two integers, high and low.\n";
print "This program will print the range of integers between them.\n\n";

print "Enter an integer: ";
chomp ($input = <STDIN>);
push @array, $input;


print "\nEnter another: ";
chomp ($input = <STDIN>);
push @array, $input;

@array = sort @array;

@array= ($array[0] .. $array[1]);

print "\n @array \n";
