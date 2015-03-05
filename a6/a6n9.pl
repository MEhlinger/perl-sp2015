#!/usr/bin/perl

# a6n9.pl - takes reddit.com/til
# By Marshall Ehlinger
# Scrapes reddot TIL and prints what people are learning today

use warnings;
use strict;

use LWP::Simple;

my $url = "http://www.reddit.com/r/todayIlearned/";
my $page = get($url);
die "$url retrieval failed" unless defined $page;

# Replace html quotation marks with chars
$page =~ s/&quot;/"/g;

print "\n\n THINGS PEOPLE ARE LEARNING \n\n";

while ($page =~ />TIL[\s:,]+?(.+?)<\/a>.+?reddit.com\/user\/(.+?)"/g) {
  print $2." learned ".$1."\n\n";
}

print "\n\n THOSE ARE FASCINATING. \n\n";
