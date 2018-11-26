#!/usr/bin/env perl 
use strict;
use warnings;
use Getopt::Long    'GetOptions';
use JSON::XS        'decode_json';
use Log::Log4perl   ':easy';
use Chaos::Toolkit  ();

Log::Log4perl->easy_init($DEBUG);

sub usage {
    my $txt = <<EOT;

    Usage: $0 -experiment <an experiment JSON file>

EOT
}

my $experiment_file;

GetOptions(
    "experiment=s" => \$experiment_file
) or die usage();

die usage() unless (defined $experiment_file );
die usage() unless -f $experiment_file;

my $c = Chaos::Toolkit->new(
    experiment_file => $experiment_file 
);
$c->run_actions();
