#!usr/bin/perl

@array = ("foo", 1, undef, 45, undef, undef, "atlas", undef, 101, undef);

foreach $item (@array) {
	if ($item eq  undef) {
		$item = "*MU*";
	}	
	print "$item ";
}
print "\n";
