package Patch::Tests::PackageClass;

use Test::More;
use base 'Test::Class';
use Patch::Package;

use strict;
use warnings;

sub class { 'Patch::Package' };

sub startup : Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub constructor : Tests(3) {
    my $test    = shift;
    my $class   = $test->class;

    can_ok $class, 'new';
    ok my $pkg  = $class->new,
        '... and the constructor should succed';
    isa_ok $pkg, $class, '... and the object it returns';
}

1;

__END__
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
