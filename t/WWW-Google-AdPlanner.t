use Test::More tests => 2;
BEGIN { use_ok('WWW::Google::AdPlanner') };

my $ad_planner = WWW::Google::AdPlanner->new();
ok(defined($ad_planner), 'new');
