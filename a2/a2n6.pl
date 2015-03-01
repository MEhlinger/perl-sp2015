#!/usr/bin/perl -w

my @counts;
my @randVals;

for (my $i = 0 ; $i < 100 ; $i++) {
  $randVals[$i] = int(rand(6));
}

@randVals = sort @randVals;

for (my $i = 0; $i <= $#randVals; $i++) {
  $counts[$randVals[$i]] ++;
}

for (my $i = 0; $i <= $#counts; $i++) {
  my $adjustVal = $i + 1;  
  printf("%5s", "$adjustVal : $counts[$i]\n");
}
