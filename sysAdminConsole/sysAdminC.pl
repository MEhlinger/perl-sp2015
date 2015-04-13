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
        printf("\n    +=+=+=+=+=+=+=+=+\n");
        printf("    SysAdmin  Console\n");
        printf("        Main Menu\n");
        printf("    +=+=+=+=+=+=+=+=+\n\n");
	printf("    ---Use as root!--\n\n");
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
        printf("\n LIST USERS\n");
        printf(" ==========\n");
        print(`cut -d: -f1 /etc/passwd`);
    }

    sub createUser {
        printf("\n CREATE USER\n");
        printf(" ===========\n");

        printf(" Enter new user name, \n");
	printf(" or 'exit' to cancel: ");
        chomp( my $userName = <STDIN> );

	if ($userName eq "exit") {
		return;
	}

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
        chomp( my $pwd = crypt( $userPassword, $salt ) );

        print(`useradd -m $userName -p '$pwd'`);

        print("Creating MySQL account for $userName\n");
        print("Enter MySQL root password: ");
        ReadMode('noecho');
        chomp( my $sqlRootPw = ReadLine(0) );
        ReadMode('normal');

        printf(" Connecting to MySQL...");
        my $dbHandle = DBI->connect( 'DBI:mysql:mysql', "root", $sqlRootPw )
          or die "Could not connect to database: " . $dbHandle->errstr;

        printf(" Adding user....");
        my $stHandle = $dbHandle->prepare("CREATE DATABASE $userName;")
          or die "Could not prepare statment: " . $dbHandle->errstr;
        $stHandle->execute();
        printf(" Granting database permissions to $userName.....\n");
        $stHandle = $dbHandle->prepare(
"grant all privileges on $userName.* to $userName\@localhost identified by '$userName';"
        ) or die "Could not prepare statement: " . $dbHandle->errstr;
        $stHandle->execute();
    }

    sub deleteUser {
        printf("\n TOTAL DELETE USER\n");
        printf(" =================\n");

        printf(
" Enter user name to delete (will erase home, MySQL database & user as well).\n"
        );
	printf(" Type 'exit' to cancel: ");
        chomp( my $userName = <STDIN> );

	if ($userName eq "exit") {
		return;
	}
	

        printf(
" Erasing all traces of $userName. We never really liked them anyway.\n"
        );
        print(`deluser $userName`);
        print(`rm -r /home/$userName`);
        printf(" Connecting to MySQL...\n");

        print("Enter MySQL root password: ");
        ReadMode('noecho');
        chomp( my $sqlRootPw = ReadLine(0) );
        ReadMode('normal');

        my $dbHandle = DBI->connect( 'DBI:mysql:mysql', "root", $sqlRootPw )
          or die "Could not connect to database: " . $dbHandle->errstr;

        printf("\n Deleting user and associated database...\n");
        my $stHandle = $dbHandle->prepare("DROP DATABASE $userName;")
          or die "Could not prepare statment: " . $dbHandle->errstr;
        $stHandle->execute();

        printf(" User $userName is no more.\n");
    }

    sub bulkCreateUsers {
        printf("\n BULK USER ACCOUNT CREATION\n");
        printf(" ==========================\n");
        printf(" Enter path to punctuation-delimited txt file of emails: ");
        chomp( my $path = <STDIN> );
	open(my $fh, "<",  $path) or die "Could not open $path.";

        print("\n Enter MySQL root password: ");
        ReadMode('noecho');
        chomp( my $sqlRootPw = ReadLine(0) );
        ReadMode('normal');

	$_ = <$fh>;

        while (/(\w+?)@/g) {
		print("debug\n\n");
            my $userName = $1;
            my $userPassword = $userName;
            
            # Create a random salt string starting with $1$ followed by 8 random
            # chars followed by $. See man crypt for definition. Then use crypt
            # to create a new 34 char digest for given plaintext password.
            my $salt = join '', ( '.', '/', 0 .. 9, 'A' .. 'Z', 'a' .. 'z' )[
              rand 64, rand 64, rand 64, rand 64,
              rand 64, rand 64, rand 64, rand 64
            ];
            $salt = '$1$' . $salt . '$';
            chomp( my $pwd = crypt( $userPassword, $salt ) );

            print(`useradd -m $userName -p '$pwd'`);

            printf(" Creating MySQL account for $userName.\n");
            printf(" Default password will be same as username.\n");

            printf(" Connecting to MySQL...");
            my $dbHandle = DBI->connect( 'DBI:mysql:mysql', "root", $sqlRootPw )
              or die "Could not connect to database: " . $dbHandle->errstr;

            printf(" Adding user....");
            my $stHandle = $dbHandle->prepare("CREATE DATABASE $userName;")
              or die "Could not prepare statment: " . $dbHandle->errstr;
            $stHandle->execute();
            printf(" Granting database permissions to $userName.....\n");
            $stHandle = $dbHandle->prepare(
    "grant all privileges on $userName.* to $userName\@localhost identified by '$userName';"
            ) or die "Could not prepare statement: " . $dbHandle->errstr;
            $stHandle->execute();
        }
    }

    sub suspendUser {
        printf("\n SUSPEND A USER\n");
        printf(" ==============\n");
        printf(" Enter user to suspend: ");
        chomp( my $userName = <STDIN> );
        print(`passwd -l $userName`);
	printf("\n $userName frozen. Think about what you've done, $userName.\n");
    }

    sub unsuspendUser {
        printf("\n UNSUSPEND A USER\n");
        printf(" ================\n");
        printf(" Enter user to unsuspend: ");
        chomp( my $userName = <STDIN> );
        print(`passwd -u $userName`);
	printf("\n $userName unfrozen. I hope you've learned something from this, $userName.");
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
printf "\n  Goodbye, sysadmin!\n";
