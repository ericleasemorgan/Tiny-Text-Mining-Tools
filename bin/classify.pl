#!/usr/bin/perl

# classify.pl - list most significant words in a text
#               based on http://en.wikipedia.org/wiki/Tfidf

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 10, 2009 - first investigations; based on search.pl
# April 12, 2009 - added dynamic corpus


# define
use constant STOPWORDS    => 'stopwords.inc';
use constant LOWERBOUNDS  => .002;
use constant NUMBEROFTAGS => 0;
use constant DIRECTORY    => '/Users/emorgan/desktop/thoreau-emerson/corpus';

# use/require
use strict;
use Lingua::StopWords qw( getStopWords );
require 'subroutines.pl';

# initialize
my @corpus = &corpus( DIRECTORY );

# index, sans stopwords
my %index = ();
foreach my $file ( @corpus ) { $index{ $file } = &index( $file, &getStopWords( 'en' ) ) }

# classify (tag) each document
my %terms = ();
foreach my $file ( @corpus ) {

	my $tags = &classify( \%index, $file, [ @corpus ] );
	my $found = 0;
	my $directory = DIRECTORY;
	
	# list tags greater than a given score
	foreach my $tag ( sort { $$tags{ $b } <=> $$tags{ $a } } keys %$tags ) {
	
		if ( $$tags{ $tag } > LOWERBOUNDS ) {
		
			$file =~ s/$directory\///e;
			print "$tag (" . $$tags{ $tag } . ") $file\n";
			
			$terms{ $tag }++;
			$found = 1;
			
		}
		
		else { last }
	
	}
	
	print "\n";
	
	# accomodate tags with low scores
	#if ( ! $found ) {
	#
	#	my $n = 0;
	#	foreach my $tag ( sort { $$tags{ $b } <=> $$tags{ $a } } keys %$tags ) {
	#		
	#		$terms{ $tag }++;
	#		$n++;
	#		last if ( $n == NUMBEROFTAGS );
	#		
	#	}
	#
	#}
		
}

foreach ( sort { $terms{ $b } <=> $terms{ $a } } keys %terms ) {

	my $key   = $_;
	my $value = $terms{ $key };
	print "$key\t$value\n";

}


# done; more fun!
exit;


