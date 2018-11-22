use strict;
use warnings;
use Log::Log4perl qw(:easy);
use LWP::ConsoleLogger::Everywhere;

Log::Log4perl->easy_init($DEBUG);

use Test::More;

BEGIN {
    use_ok('Chaos::Toolkit');
}

ok( my $c = Chaos::Toolkit->new( experiment_file => './scripts/exp1.json' ), 'new' );
ok( $c->run_actions(), 'run_actions' );

done_testing;
