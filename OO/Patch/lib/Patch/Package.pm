package Patch::Package;

use Moose;

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    writer  => 'set_name',
    reader  => 'get_name',
);

for my $name ( qw/version available_version/ ) {
    has $name => (
        is      => 'ro',
        isa     => 'Str',
        writer  => "set_$name",
        reader  => "get_$name",
    );
}

1;
