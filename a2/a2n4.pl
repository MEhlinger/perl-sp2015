#!/usr/bin/perl -w

$input = ''; # temporary input
@nums = ();
$count = 0;  # count of numbers
$sum = 0;    # sum of numbers
$avg = 0;    # average
$med = 0;    # Median
$sDev = 0;   # Standard deviation


while () {
  print 'Enter a number: ';
  chomp ($input = <STDIN>);
  if ($input eq '') { last; }

  if ($input =~ /\D/) {
      print "Digits only, please.\n";
      next;
  }

  push @nums, $input;
  $count++;
  $sum += $input;
}

@nums = sort {$a <=> $b} @nums;
$avg = $sum / $count;
$med = $nums[$count / 2];

$variance = 0;
for (my $i = 0; $i < $#nums; $i++) {
  $variance += ($avg - $nums[$i])**2;   
}
$variance = $variance / $#nums;
$sDev = sqrt($variance);


print "\nTotal count of numbers: $count\n";
print "Total sum of numbers: $sum\n";
printf("Average (mean): %.2f\n", $avg);
print "Max:  $nums[$#nums]\n";
print "Min:  $nums[0]\n";
print "Median: $med\n";
print "Standard Deviation:  $sDev\n";
