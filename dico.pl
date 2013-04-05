#!/usr/bin/env perl

use strict;

sub dicotomic_search {
    my ($value, $vector, $left, $right) = @_;    
    print "userrr " if $value eq "wpixar";
    return if ($left > $right);

    my $middle = ($left + $right)/2;
    if    ($value lt $vector->[$middle]) { return dico($value, $vector, $left, $middle-1);  }
    elsif ($value gt $vector->[$middle]) { return dico($value, $vector, $middle+1, $right); }
    else {
        return $vector->[$middle];    
    }
}

