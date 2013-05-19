package Package;

use Moose;

has 'name' => (
    is      => 'ro',
    isa     => 'Str',
    writer  => 'set_name',
    reader  => 'get_name',
);

has 'version' => (
    is      => 'ro',
    isa     => 'Str',
    writer  => 'set_version',
    reader  => 'get_version',
);

has 'available_version' => (
    is      => 'ro',
    isa     => 'Str',
    writer  => 'set_available_version',
    reader  => 'get_available_version',
);


1;
