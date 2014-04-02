#!/usr/bin/perl

# ideas.pl - search texts and rank results according
#            to tfidf and "great idea coefficient"

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 25, 2009 - first investigations; based on search.pl


# define
use constant STOPWORDS => 'stopwords.inc';
use constant IDEAS     => 'ideas.inc';

# use/require
use strict;
require 'subroutines.pl';

# get the input
my $q = lc( $ARGV[ 0 ] );
if ( ! $q ) {

	print "Usage: $0 <query>\n";
	exit; 

}

# index, sans stopwords
my %index = ();
foreach my $file ( &corpus ) { $index{ $file } = &index( $file, &slurp_words( STOPWORDS ) ) }

# search
my ( $hits, @files ) = &search( \%index, $q );
print "Your search found $hits hit(s)\n";

# rank
my $ranks = &rank( \%index, [ @files ], $q );

# great idea coefficients
my $coefficients = &great_ideas( \%index, [ @files ], &slurp_words( IDEAS ) );

# combine ranks and coefficients
my %scores = ();
foreach ( keys %$ranks ) { $scores{ $_ } = $$ranks{ $_ } + $$coefficients{ $_ } }

# sort by score and display
foreach ( sort { $scores{ $b } <=> $scores{ $a } } keys %scores ) {

	print "\t", $scores{ $_ }, "\t", $_, "\n"
	
}

# done, even more fun with tfidf
print "\n";
exit;


