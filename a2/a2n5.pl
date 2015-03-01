#!/usr/bin/perl

print "How many randos to generate? ";
chomp ($input = <STDIN>);
@ints = ();
for (my $i = 1; $i < $input+1; $i++) {
  $ints[$i-1] = int(rand(401)) + 100;
  if ($i % 10 == 0) {
    print "$ints[$i-1] \n";
  } else {
  print "$ints[$i-1] ";
  }
}
print "\nNow, sorted ascending: \n";
@ints = sort { $a <=> $b } @ints;
for (my $i = 1; $i < $#ints+2; $i++) {
  if ($i % 10 == 0) {
    print "$ints[$i-1] \n";
  } else {
    print "$ints[$i-1] ";
  }
}
print "\nNow sorted descending: \n";
@ints = sort { $b <=> $a } @ints;
for (my $i =1; $i < $#ints+2; $i++) {
  if ($i % 10 == 0) {
    print "$ints[$i-1] \n";
  } else {
    print "$ints[$i-1] ";
  }
}
print "\n\n";
