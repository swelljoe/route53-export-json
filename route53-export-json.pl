V#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use WebService::Amazon::Route53;
use JSON;

my $client = WebService::Amazon::Route53->new(id => 'KEY_ID',
                                              key => 'SECRET_KEY');

my $response = $client->list_hosted_zones(max_items => 100);

for my $zones ($response->{'hosted_zones'}) {
    for my $zone (@$zones) {
        my $zonedetails = $client->list_resource_record_sets(zone_id => $zone->{'id'});
        print JSON::XS->new->utf8->pretty->encode($zonedetails);
    }
}
