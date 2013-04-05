#!/usr/bin/env perl

use Opsview::REST;
use Data::Dumper;

use strict;
use warnings;

my $ops = Opsview::REST->new(
	base_url => 'http://127.0.0.1/rest',
	user	 => 'test',
	pass	 => 'test'
);

my $hosts = $ops->get_hosts(
	-or => [ 
		name => { -like => 'Debian2' },
		ip	 => { -like => 172.16.88.132}
	],
);

print $hosts;
