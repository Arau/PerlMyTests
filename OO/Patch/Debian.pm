package Patch::Debian;

use Moose;

has 'packages' => (
    is      => 'rw',
    isa     => 'ArrayRef[Patch::Package]',
    traits  => ['Array'],
    default => sub { [] },
    handles => {
        add_item  => 'push',
        next_item => 'shift',
    },
    reader  => 'get_packages',
);

sub update_repo_cmd {
    return "aptitude update";
}

sub updates_list_cmd {
    return "aptitude search --disable-columns -F '%p;%v;%V' ~U";
}

sub update_packages_cmd {
    return "aptitude safe-upgrade -y -o APT::Get::AllowUnauthenticated=true";
}

sub parse_updates_list {
    my ($self, $list) = @_;

    foreach my $line ($list) {
        my ($name, $version, $avail) = split /;/, $list;
        self->packages->add_item(Patching::Package->new(
                {
                    name              => $name,
                    version           => $version,
                    available_version => $avail,
                })
        );
    }
}

sub print_updates {
    my $self = shift;
    map {
        print "Package: $_->get_name ";
        print "Version: $_->get_version ";
        print "Available: $_->get_available_version \n";
    } @$self->packages;
}


1;
