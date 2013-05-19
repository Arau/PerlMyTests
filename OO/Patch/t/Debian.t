package Patch::Debian::Tests;

use Test::More;
use Patch::Debian;
use Patch::Package;

use strict;
use warnings;

#
# Previous stubs
#

my $mysql = Patch::Package->new({
        name              => 'MySQL',
        version           => '5.1',
        available_version => '5.5',
    });

my $apache = Patch::Package->new({
        name              => 'Apache2',
        version           => '2.1',
        available_version => '2.2',
    });

my $packages = [$mysql, $apache];
my $obj = Patch::Debian->new(
    {
        packages => $packages
    });

my $raw_list = "Perl;5.10;5.18\ngcc;3.12;4.1";


#
#Tests
#

ok($obj, "Instantiate object");
is($obj->update_repo_cmd, "aptitude update", "Aptitude update command");
is($obj->updates_list_cmd, "aptitude search --disable-columns -F '%p;%v;%V' ~U", "Aptitude search upgradable packages");
is($obj->update_packages_cmd, "aptitude safe-upgrade -y -o APT::Get::AllowUnauthenticated=true", "Aptitude safe-upgrade assume yes");

#ToDo with subtest
#$obj->parse_updates_list($raw_list);
#my @packages = $obj->get_packages();


done_testing();
