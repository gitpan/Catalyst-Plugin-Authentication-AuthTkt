use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Catalyst::Plugin::Authentication::AuthTkt',
    AUTHOR              => 'Peter Karman <karman at cpan dot org>',
    VERSION_FROM        => 'lib/Catalyst/Plugin/Authentication/AuthTkt.pm',
    ABSTRACT_FROM       => 'lib/Catalyst/Plugin/Authentication/AuthTkt.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Catalyst::Runtime' => 0,
        'Apache::AuthTkt'   => 0.07,
        'Catalyst::Plugin::Authentication' => 0.10,


    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Catalyst-Plugin-Authentication-AuthTkt-*' },
);
