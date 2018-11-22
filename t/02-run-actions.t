use strict;
use warnings;
use Log::Log4perl qw(:easy);
use Proc::Find    qw( proc_exists );

Log::Log4perl->easy_init($DEBUG);

use Test::More;

BEGIN {
    use_ok('Chaos::Toolkit');
}

SKIP: {
    skip "toxiproxy server not running", 2 unless proc_exists( name => 'toxiproxy-server' );
    ok( my $c = Chaos::Toolkit->new( experiment_file => './scripts/exp1.json' ), 'new' );
    ok( $c->run_actions(), 'run_actions' );
}

done_testing;
