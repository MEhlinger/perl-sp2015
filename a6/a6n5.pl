#!/usr/bin/perl

# a6n5.pl by Marshall Ehlinger
# process auth.log file, output ip, frequency of loging attempts, and location
# call as: perl a6n5.pl /home/public/auth.log

use warnings;
use strict;

my $count  = 0;
my %iphash = ();

while ( my $row = <> ) {
    chomp $row;
    if ( $row =~ /(\d+\.\d+\.\d+\.\d+)/ ) {
        $iphash{$1}++;
    }
    $count++;
}
foreach my $key ( sort { $iphash{$a} <=> $iphash{$b} } keys %iphash ) {
    if($iphash{$key} >= 500) {
        printf "%15s : %5d : %-25s\n", $key, $iphash{$key}, lookupip($key);
    }
}

print "Total lines in file / entry attempts: $count\n";

use LWP::Simple;

sub lookupip {
    my $ip      = shift;
    my $url     = "http://www.abuseipdb.com/check/$ip";
    my $webpage = get($url);
    die "Not able to retrieve $url" unless defined $webpage;
    my $country;
    my $city;

# Captures everything between the first <td> tag and close after the appearance of "Country"
    if ( $webpage =~ /Country:.*?<td>(.*?)<.*?City:.*?<td>(.*?)</xmigs ) {
         $country =  $1;
         $city    =  $2;
    }
    return "$city, $country";
}
