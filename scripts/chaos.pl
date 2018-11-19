#!/usr/bin/env perl 
use strict;
use warnings;
use Getopt::Long    'GetOptions';
use JSON::XS;
use Log::Log4perl   ':easy';

Log::Log4perl->easy_init($DEBUG);

sub usage {
    my $txt = <<EOT;

    Usage: $0 <an experiment JSON file>

EOT
}

my ( $experiment_file );

GetOptions(
    "experiment=s" => \$experiment_file
) or die usage();

die usage() unless -f $experiment_file;

