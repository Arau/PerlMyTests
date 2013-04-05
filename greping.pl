#!/user/bin/env perl

use strict;

my @list = qw/a b c d aa bb cc dd/;

my @greped = grep { /$ARGV[0]/ } @list;

map { print $_ . "\n" } @greped;


