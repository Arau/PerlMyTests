#!/usr/bin/env perl

use strict;
use warnings;

use Patch::Debian;
use Patch::Package;

my $raw_list  = "curl;7.21.0-2.1+squeeze2;7.21.0-2.1+squeeze3\n";
   $raw_list .= "libapache2-mod-php5;5.3.22-1~dotdeb.0;5.3.25-1~dotdeb.0\n",
   $raw_list .= "sudo;1.7.4p4-2.squeeze.3;1.7.4p4-2.squeeze.4\n";

my $obj = Patch::Debian->new;
$obj->parse_updates_list($raw_list);
$obj->print_updates();

