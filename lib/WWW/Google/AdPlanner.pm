#!/usr/bin/perl
use strict;

package WWW::Google::AdPlanner;
use LWP::UserAgent;
use JSON;

use vars qw($VERSION);

BEGIN {
    $VERSION = '1.00';
}

sub new {
    my $class = shift;
    my $this = {
        ua => LWP::UserAgent->new(),
    };
    return bless($this, $class);
}

sub site_details {
    my ($this, $site, $geo) = @_;
    
    $geo = '' if !defined($geo);
    $geo = uc($geo);
    
    my $url = "https://www.google.com/adplanner/planning/site_details_data?identifier=$site&trait_type=1&geo=$geo";
    my $response = $this->{ua}->get($url);
    
    if(!$response->is_success()) {
        die("URL $url: " . $response->message());
    }
    
    my $json = $response->decoded_content();
    my $details = from_json($json);
    
    return $details;
}

1;

__END__

=head1 NAME

WWW::Google::AdPlanner - retrieve web site statistics from Google Ad Planner

=head1 SYNOPSIS

    use WWW::Google::AdPlanner;
    use Data::Dumper;
    
    my $ad_planner = WWW::Google::AdPlanner->new();
    my $site_details = $ad_planner->site-details('cpan.org', 'US');
    print Dumper($site_details);

=head1 DESCRIPTION

WWW::Google::AdPlanner retrieves web site statistics from Google Ad Planner
by loading a JSON file from:

https://www.google.com/adplanner/planning/site_details_data

At the time of this writing, this information can be retrieved by everyone
without logging in to Google.

=head1 CONSTRUCTOR

=head2 new

    my $ad_planner = WWW::Google::AdPlanner->new();

Creates a new AdPlanner object.

=head1 OBJECT METHODS

=head2 site_details

    $ad_planner->site_details($host, $country);

Retrieves statistics for web site $host. Currently, Google Ad Planner only
supports entire domains. The $country code tells for which country additional
information should be gathered. The return value is a hashref directly
converted from JSON data. Use Data::Dumper to show the structure of the
returned data.

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

Copyright (C) Nick Wellnhofer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.6.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
