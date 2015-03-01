#!/usr/bin/perl -w

# This is a single-line comment 

print "Enter your name: ";
chomp($name = <STDIN>);
print "Your name is $name!\n";

$x = 5;
print "Hello World\n$x\n";
$x = "Scalar variables begin with a dollar sign.";
print "Now x = $x\n";
printf "%d\n", 3.1415126;
printf "The cost is \$%.2f\n", 499.56789;

$a = 123.456;
print ("Some Number:");
$num = sprintf("%8.2f\n", $a);
print $num;

print "-------------------------\n";

$trimNum = 2.546;
printf ("%.f\n", $trimNum); # Using the period in a printf formatting string without a following value rounds to 1 digit, no decimals.
