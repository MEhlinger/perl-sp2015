#!/usr/bin/perl
# a6n4.pl by Marshall Ehlinger
# call as : perl a6n4.pl <ipaddress>

use strict;
use warnings;

use LWP::Simple;

my $ip = $ARGV[0];
my $url = "http://www.abuseipdb.com/check/$ip";
my $webpage = get($url);
die "Not able to retrieve $url" unless defined $webpage;
my $country = "No Country Found";
my $city = "No City Found";

# Captures everything between the first <td> tag and close after the appearance of "Country"
if ($webpage =~ /Country:.*?<td>(.*?)<.*?City:.*?<td>(.*?)</xmigs) {
  $country = $1;
  $city = $2;
}
print "$city, $country\n";
