#!/usr/bin/perl

# Sysadmin Console for Ubuntu
# Written in Perl. Run as root user.
# By Marshall Ehlinger
# For Operating Systems Exam 2, Spring 2015

use warnings;
use strict;
use Switch;

sub mainMenu {
	printf("\n    SysAdmin Console\n");
	printf("       Main Menu\n\n");
	printf(" (1) List User Accounts\n");
	printf(" (2) Add User Account + MySQL\n");
	printf(" (3) Delete User Account + MYSQL\n"); 
	printf(" (4) Bulk Create User + MySQL Accounts\n"); 
	printf(" (5) Suspend User Account\n");
	printf(" (6) Unsuspend User Account\n"); 
	printf(" (7) Exit Sysadmin Menu\n\n");

	while() {
		printf(" Enter integer value corresponding to your menu choice:\n"); 
		chomp(my $input = <STDIN>);
		if ($input =~ /[1..7]/) {
			return $input;
		}
	}
	
}

# MAIN PROGRAM LOOP
my $looping = 1;
while($looping) {
	my $menuOption = mainMenu();
	switch ($menuOption) {
		case 1	{ listUsers() }
		case 2	{ createUser() }
		case 3	{ deleteUser() }
		case 4	{ bulkCreateUsers() }
		case 5	{ suspendUser() }
		case 6	{ unsuspendUser() }
		case 7	{ $looping = !$looping }
		else	{ printf("ERROR: Invalid input provided by mainMenu() ") }

	
	}
}
printf "\nGoodbye!\n";
