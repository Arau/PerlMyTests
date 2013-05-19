package Patch::Tests::Debian;

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

#
#Tests
#

subtest 'Debian commands' => sub {
    ok $obj, "Instantiate object";

    is $obj->update_repo_cmd, "aptitude update", "Aptitude update command";

    is $obj->updates_list_cmd, "aptitude search --disable-columns -F '%p;%v;%V' ~U",
        "Aptitude search upgradable packages";

    is $obj->update_packages_cmd, "aptitude safe-upgrade -y -o APT::Get::AllowUnauthenticated=true",
        "Aptitude safe-upgrade assume yes";
};

subtest 'One package for test parser' => sub {
    my $raw_list = "Perl;5.10;5.18";
    my $obj = Patch::Debian->new();
    $obj->parse_updates_list($raw_list);
    my $pkg = $obj->next_item();
    is $pkg->get_name,              'Perl', '... name of package parsed ok?';
    is $pkg->get_version,           '5.10', '... version of package parsed ok?';
    is $pkg->get_available_version, '5.18', '... available_version parsed ok?';
};

subtest 'Multiple packages to test parser' => sub {
    my $raw_list = "gcc;3.21;4.1\ngcc;3.21;4.1\ngcc;3.21;4.1";
    my $obj = Patch::Debian->new();
    $obj->parse_updates_list($raw_list);
    my $i = 1;
    while (my $pkg = $obj->next_item()) {
        is $pkg->get_name,              'gcc', "... name of package $i parsed ok?";
        is $pkg->get_version,           '3.21',"... version of package $i parsed ok?";
        is $pkg->get_available_version, '4.1', "... available_version $i parsed ok?";

        $i++;
    }
};

done_testing();
