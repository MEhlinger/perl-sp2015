#!/usr/bin/perl

# Sysadmin Console for Ubuntu
# Written in Perl. Run as root user.
# By Marshall Ehlinger
# For Operating Systems Exam 2, Spring 2015

use warnings;
use strict;
use Switch;
use Term::ReadKey;
use DBI;

ReadMode 1;

BEGIN {
    my $dbHandle;

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

        while () {
            printf(" Enter integer value corresponding to your menu choice: ");
            chomp( my $input = <STDIN> );
            if ( $input =~ /[1-7]/ ) {
                return $input;
            }
        }
    }

    sub listUsers {
        printf(" USERS:\n");
        print(`cut -d: -f1 /etc/passwd`);
    }

    sub createUser {
        printf(" Enter new user name: ");
        chomp( my $userName = <STDIN> );

        ReadMode('noecho');
        printf(" Enter password: ");
        chomp( my $userPassword = ReadLine(0) );
        ReadMode('normal');

        # Create a random salt string starting with $1$ followed by 8 random
        # chars followed by $. See man crypt for definition. Then use crypt
        # to create a new 34 char digest for given plaintext password.
        my $salt = join '', ( '.', '/', 0 .. 9, 'A' .. 'Z', 'a' .. 'z' )[
          rand 64, rand 64, rand 64, rand 64,
          rand 64, rand 64, rand 64, rand 64
        ];
        $salt = '$1$' . $salt . '$';
        chomp(my $pwd = crypt( $userPassword, $salt ));

        print(`useradd -m $userName -p '$pwd'`);

        print("Creating MySQL account for $userName\n");
        print("Enter MySQL root password: ");
        ReadMode('noecho');
        chomp(my $sqlRootPw = ReadLine(0));
        ReadMode('normal');

        printf(" Connecting to MySQL...");
        my $dbHandle = DBI->connect( 'DBI:mysql:mysql', "root", $sqlRootPw )
          or die "Could not connect to database: " . $dbHandle->errstr;

        printf(" Adding user....");
        my $stHandle = $dbHandle->prepare("CREATE DATABASE $userName;")
          or die "Could not prepare statment: " . $dbHandle->errstr;
        $stHandle->execute();
        printf(" Granting database permissions to $userName.....");
        $stHandle = $dbHandle->prepare(
"grant all privileges on $userName.* to $userName\@localhost identified by '$userName';"
        ) or die "Could not prepare statement: " . $dbHandle->errstr;
        $stHandle->execute();

    }

}

# MAIN PROGRAM LOOP
my $looping = 1;
while ($looping) {
    my $menuOption = mainMenu();
    switch ($menuOption) {
        case 1 { listUsers() }
        case 2 { createUser() }
        case 3 { deleteUser() }
        case 4 { bulkCreateUsers() }
        case 5 { suspendUser() }
        case 6 { unsuspendUser() }
        case 7 { $looping = !$looping }
        else   { printf("ERROR: Invalid input provided by mainMenu() ") }

    }
}
printf "\nGoodbye!\n";
