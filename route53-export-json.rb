#!/usr/bin/env ruby
require 'aws-sdk'
require 'json'
require 'inifile'
require 'pp'

creds = IniFile.load('/home/joe/.aws/credentials')

client = Aws::Route53::Client.new(
  access_key_id: creds['default']['access_key_id'],
  secret_access_key: creds['default']['secret_access_key'],
  region: creds['default']['region']
)

# List of zones
zones = client.list_hosted_zones['hosted_zones']

zones.each do |zone|
  zone[:id]
  records = client.list_resource_record_sets(
    hosted_zone_id: zone[:id]
  )
  records[:resource_record_sets].each do |record|
    puts JSON.pretty_generate(record.to_h)
  end
end
