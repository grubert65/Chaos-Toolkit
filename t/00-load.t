#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Chaos::Toolkit' ) || print "Bail out!\n";
}

diag( "Testing Chaos::Toolkit $Chaos::Toolkit::VERSION, Perl $], $^X" );
