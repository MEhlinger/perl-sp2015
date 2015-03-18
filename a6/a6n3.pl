#!/usr/bin/perl
# a6n3.pl by Marshall Ehlinger
# Search html web page for data
# Call as: perl a6n3.pl abuseipdb.html

use strict;
use warnings;

while (<>) {
  if (/Country:/) {
    my $country  = <>;
    if ($country =~ /<td>(.*?)</) {
      $country = $1;
    }
    print "$country\n"
  }
}
