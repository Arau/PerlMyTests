package Patch::Tests::Package;

use Test::More;

use strict;
use warnings;


BEGIN {
    use_ok 'Patch::Package';
}

my $obj = Patch::Package->new({
        name              => 'MySQL',
        version           => '5.1',
        available_version => '5.5',
    });

isa_ok $obj, 'Patch::Package', "Instantiate object";

is $obj->get_name(), 'MySQL', "Right name";
is $obj->get_version(), '5.1', "Right current version";
is $obj->get_available_version(), '5.5', "Right available version";

done_testing();
