#!/usr/bin/perl

# search.pl - search texts and rank results
#             based on http://en.wikipedia.org/wiki/Tfidf

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 5, 2009  - first investigations
# April 6, 2009  - prettified code
# April 10, 2009 - required library of subroutines
# April 11, 2009 - added stopwords
# April 12, 2009 - added dynamic corpus


# define
use constant DIRECTORY => '/Users/emorgan/desktop/thoreau-emerson/corpus';

# use/require
use strict;
use Lingua::StopWords qw( getStopWords );
require 'subroutines.pl';

# get the input
my $q = lc( $ARGV[ 0 ] );
if ( ! $q ) {

	print "Usage: $0 <query>\n";
	exit; 

}

# index, sans stopwords
my %index = ();
foreach my $file ( &corpus( DIRECTORY ) ) { $index{ $file } = &index( $file, &getStopWords( 'en' ) ) }

# search
my ( $hits, @files ) = &search( \%index, $q );
print "Your search found $hits hit(s)\n";

# rank
my $ranks = &rank( \%index, [ @files ], $q, DIRECTORY );

# sort by rank and display
foreach my $file ( sort { $$ranks{ $b } <=> $$ranks{ $a } } keys %$ranks ) {

	print "\t", $$ranks{ $file }, "\t", $file, "\n"
	
}

# done, fun with tfidf
print "\n";
exit;


