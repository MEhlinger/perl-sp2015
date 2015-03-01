#!/usr/bin/perl 

use warnings;
use strict;

my $index = 0;
my @grades = ();
my $input;

print ("Enter scores, 0-100... negative to cease entry: \n");

while ($index >= 0) {
  print "Enter value: ";
  chomp( $input = <STDIN> );
  if (($input =~ /[^\D]/) && ($input >= 0) && ($input <= 100)) {
    push @grades, $input;
  } else {
    $index = -1;
  }
}

@grades = sort @grades;

my $best = $grades[$#grades];

for (my $i = 0; $i <= $#grades; $i++) {
  if ($grades[$i] == $best) {
    print ("$grades[$i] : A+ Best Grade Good Jorb!\n");
  } elsif ($grades[$i] >= ($best - 10)) {
    print ("$grades[$i] : A \n");
  } elsif ($grades[$i] >= ($best - 20)) {
    print ("$grades[$i] : B \n");
  } elsif ($grades[$i] >= ($best - 30)) {
    print ("$grades[$i] : C \n"); 
  } elsif ($grades[$i] >= ($best -40)) {
    print ("$grades[$i] : D \n");
  } else {
    print ("$grades[$i] : I'm not angry, I'm just disappointed.\n");
  }
}
