#!/usr/bin/env python
import json

import boto3

# Can also use an ~/.aws/credentials file
client = boto3.client(
    'route53',
    aws_access_key_id = '<access_key>',
    aws_secret_access_key = '<secret_key>',
)

response = client.list_hosted_zones(
    MaxItems='100',
)

for zone in response["HostedZones"]:
    record_sets = client.list_resource_record_sets(
        HostedZoneId = zone["Id"],
    )
    print (json.dumps(record_sets['ResourceRecordSets'], indent = 4, sort_keys = True, default = str ))
