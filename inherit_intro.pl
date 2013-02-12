#!/usr/bin/env perl


#my $obj = XXX->new;
#my $s = 'method';
#$obj->$s();

my $m = $ARGV[0];

my $dispatch = {
    X => sub {
      print "X\n";
    },
    Y => sub {
      print "Y\n";
    }
};

my $o2 = {
    X => sub { print "O2X\n" }
};

sub hereda {
  my ($de, $a) = @_;

  foreach my $method (keys %$de) {
    if (not defined $a->{ $method }){
        $a->{ $method } = $de->{ $method }
    } else {
        my $first = $de->{ $method };
        my $second = $a->{ $method };
        my $new = sub {
           $first->();
           $second->();
        };
        $a->{ $method } = $new;
    }
  }
}

hereda($dispatch, $o2);

$o2->{ $m }->() if (defined $o2->{ $m });
