#!usr/bin/perl -w

@nums = ();
print "Enter numbers one at a time, ";
print "and enter a 0 to halt entry. ";
chomp ($input = <STDIN>);
push @nums, $input;
while ($input) {
	print "Enter value: ";
	chomp ($input = <STDIN>);
	if ($input) {
		push @nums, $input;
	}
}
@nums = sort( {$b <=> $a} @nums);
print "\nEntered values, descending: \n";
foreach $value (@nums) {
	print "$value\n";
}


