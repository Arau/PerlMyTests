#!/usr/bin/env perl

use Time::localtime;
use Data::Dumper;

sub epoch {
    my $epoch = shift;
    my $date  = ctime($x);
    print Dumper($epoch);
    print Dumper($date);
}

epoch(time);
