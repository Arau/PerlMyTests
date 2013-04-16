#!/usr/bin/env perl

use strict;
use autodie;
use warnings;

use Data::Dumper;

# Get 2 lists 
my $list1 = open_read(shift @ARGV);
my $list2 = open_read(shift @ARGV);

my %first  = map { $_ => 1 } @$list1;
my %second = map { $_ => 1 } @$list2;

# Intersection
my @first_and_second = grep($first{$_}, @$list2);

# negate Intersection
my @first_not_second = grep(!defined $second{$_}, @$list1); 

map { print "$_ \n" } @first_and_second;

print "\n";

map { print "$_ \n" } @first_not_second;

sub open_read {
    my $path = shift;

    open (my $fh, '<', $path); # Autodie if not open
    chomp( my @content = <$fh>);
    close($fh);

    return \@content;
}

