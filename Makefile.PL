use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'WWW::Google::AdPlanner',
    DISTNAME          => 'WWW-Google-AdPlanner',
    VERSION_FROM      => 'lib/WWW/Google/AdPlanner.pm',
    PREREQ_PM         => {
        'LWP::UserAgent' => undef,
        'JSON'           => undef,
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/WWW/Google/AdPlanner.pm',
       AUTHOR         => 'Nick Wellnhofer <wellnhofer@aevum.de>') : ()),
);
