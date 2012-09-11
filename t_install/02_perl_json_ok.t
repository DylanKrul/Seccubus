#!/usr/bin/env perl
# ------------------------------------------------------------------------------
# $Id$
# ------------------------------------------------------------------------------
# This little script checks all files te see if they are perl files and if so 
# ------------------------------------------------------------------------------

use strict;
use Test::More;

my $tests = 0;
my $pwd = `pwd`;

my @files = split(/\n/, `cd tmp/install/seccubus/www/seccubus/json;find . -type f`);

foreach my $file ( @files ) {
	if ( $file !~ /\/\./ &&			# Skip hidden files
	     $file !~ /\.(html|css|js|ejs|3pm|gif|jpg|png|pdf|doc|xml|nbe|txt)/i
	     					# Skip know extensions
	) { #skip hidden files
		my $type = `file 'tmp/install/seccubus/www/seccubus/json/$file'`;
		chomp($type);
		if ( $type =~ /Perl/i ) {
			
			like(`(cd tmp/install/seccubus/www/seccubus/json;perl -I$pwd/t -c '$file' 2>&1)`, qr/OK/, "$file perl compile test");
			$tests++;
		}
	}
}
done_testing($tests);
