use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chaos::Toolkit');
}

ok( my $c = Chaos::Toolkit->new( experiment_file => './scripts/exp1.json' ), 'new' );
is( ref $c->experiment->{actions}, 'ARRAY', 'got right data type back');
is( scalar @{$c->experiment->{actions}}, 2, 'the number of actions is ok');
is( $c->experiment->{actions}->[0]->{module}, 'ToxiProxy', 'got right data back' );

done_testing;
