#!/usr/bin/perl -w

$input = ''; # temporary input
$count = 0;  # count of numbers
$sum = 0;    # sum of numbers
$avg = 0;    # average
$min = "empty";
$max = 0;


while () {
  print 'Enter a number: ';
  chomp ($input = <STDIN>);
  if ($input eq '') { last; }

  if ($input =~ /\D/) {
      print "Digits only, please.\n";
      next;
  }
  if ($min eq "empty") {
	$min = $input;
  }
  $count++;
  $sum += $input;
  if ($input > $max) {
	$max = $input;
  }
  if ($input < $min) {
	$min = $input;
  }
}

$avg = $sum / $count;


print "\nTotal count of numbers: $count\n";
print "Max = $max\n";
print "Min = $min\n";
print "Total sum of numbers: $sum\n";
printf("Average (mean): %.2f\n", $avg);

