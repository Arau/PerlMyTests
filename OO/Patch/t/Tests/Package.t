package Patch::Tests::Package;

use Test::More;
use Patch::Package;

use strict;
use warnings;

my $obj = Patch::Package->new({
        name              => 'MySQL',
        version           => '5.1',
        available_version => '5.5',
    });

ok($obj, "Instantiate object");

is($obj->get_name(), 'MySQL', "Right name");
is($obj->get_version(), '5.1', "Right current version");
is($obj->get_available_version(), '5.5', "Right available version");

done_testing();