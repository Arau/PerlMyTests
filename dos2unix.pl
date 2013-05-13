#!/usr/bin/env perl

use strict;
use Data::Dumper;

sub dos2unix {
    my @items = @_; // Do not modify @_ directly
    s/\r\n/\n/g for @items;
    return @items;
}

print Dumper(dos2unix("aa \r\n", "b\n", "asd\r\n"));
