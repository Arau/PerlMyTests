#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

package Base;

sub new {
    say "Base new";
    my $class = shift;
    my $self  = { 
        defined => 'base',
        test    => 'test',
    };

    bless $self, $class;
    return $self;
}

sub inspect_me {
    my $self = shift;
    use Data::Dumper;
    print Dumper($self);
}

sub DESTROY {
    my $self = shift;
    say "Base destroy";
    $self->inspect_me;
}


package Sub;

our @ISA = qw( Base );

sub new {
    say "Sub new";
    my $class = shift;
    my $self  = $class->SUPER::new();
    $self->{defined} = 'sub';

    bless $self, $class;
    return $self;
}

sub defined {
    my $self = shift;
    say $self->{defined};
}

sub DESTROY {
    my $self = shift;
    $self->SUPER::DESTROY;
    say "Sub destroy";
    $self->inspect_me;
}

package main;

my $sub = new Sub();
$sub->defined;



