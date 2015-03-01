#!usr/bin/perl

print "\nHow many randos to generate? Enter integer: ";
chomp($input = <STDIN>);
for (my $i = 0; $i < $input; $i++) {
	$rando = int(rand(10)) + 1;
	print ("$rando \n");
}

