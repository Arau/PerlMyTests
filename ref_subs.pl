#!/usr/local/bin/env perl

use Data::Dumper;

use strict;

sub sum {
    return @_[0] + @_[1];
}

sub res {
    my @params = @_;
    return @_[0] - @_[1];
}

my $a = 8;
my $b = 2;

my $hash = {
            'sum' => sum($a,$b),
            'res' => res($a,$b)
           };

my $routines = {
                'sum' => sub {
                            return @_[0] + @_[1];
                        },

                'res' => sub {
                            return @_[0] - @_[1];
                        }
    
               };

my $sum = $routines->{'sum'}->($a,$b);
my $res = $routines->{'res'}->($a,$b);

print Dumper($hash);

print "suma amb refs: $sum\nresta amb refs: $res \n";

