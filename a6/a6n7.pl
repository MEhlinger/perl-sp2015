#!/usr/bin/perl
# a6n7.pl by Marshall Ehlinger
# processes /home/public/log.sql
# Displays number of students logged in each hour of the day for monday, 9/11/2000
# Display as ASCII histogram
# SQL values are presented in the order of: logId, studentId, timestamp, and login/logout val

# SO. I figure one of two things is true. A) SQL timestamps are not dates, thus
# I cannot figure out which entries are from 2000, or
# B) you meant 2002, not 2000. I will assume the latter so that i get something working.

use strict;
use warnings;

open (my $fh, "/home/public/log.sql") or die "could not open log.sql";
# Danger zone.
my %logins= (
	"00" => 0,
	"01" => 0,
	"02" => 0,
	"03" => 0,
	"04" => 0,
	"05" => 0,
	"06" => 0,
	"07" => 0,
	"08" => 0,
	"09" => 0,
	"10" => 0,
	"11" => 0,
	"12" => 0,
	"13" => 0,
	"14" => 0,
	"15" => 0,
	"16" => 0,
	"17" => 0,
	"18" => 0,
	"19" => 0,
	"20" => 0,
	"21" => 0,
	"22" => 0,
	"23" => 0,
);


while (<$fh>) {
  chomp;
  if (/20020911(\d\d).*'i'/) { 
    $logins{$1}++;
  }
}

print "\n  Hour : Login Histogram\n";

my $histo;
foreach my $key (sort {$a <=> $b} keys %logins) {
  $histo = " ";
  for (my $i = 0; $i < $logins{$key}; $i++) {
    $histo .= "*";
  }
  print "$key : $histo\n";
}

print "\nTrick question? See comments....\n"

