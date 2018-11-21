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

    Usage: $0 <an experiment JSON file>

EOT
}

my ( $experiment_file );

GetOptions(
    "experiment=s" => \$experiment_file
) or die usage();

die usage() unless -f $experiment_file;

my $experiment;
{
    local $/;
    open my $fh, "<$experiment_file"
        or die "Error opening file $experiment_file: $!\n";
    my $json_str=<$fh>;
    $experiment = decode_json( $json_str );
    close $fh;

}

my $c = Chaos::Toolkit->new(
    actions => $experiment->{actions}
);
$c->run_actions();
