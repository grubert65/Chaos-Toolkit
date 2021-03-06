use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Chaos::Toolkit',
    AUTHOR           => q{Marco Masetti <grubert65@gmail.com>},
    VERSION_FROM     => 'lib/Chaos/Toolkit.pm',
    ABSTRACT_FROM    => 'lib/Chaos/Toolkit.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    EXE_FILES        => [
        'scripts/chaos.pl',
    ],
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        'Moo'               => 0,
        'Types::Standard'   => 0,
        'Time::HiRes'       => 0,
        'JSON::XS'          => 0,
        'Log::Log4perl'     => 0,
        'Try::Tiny'         => 0,

    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Chaos-Toolkit-*' },
);
