package Patch::Debian;

use Moose;

has 'packages' => (
    is      => 'rw',
    isa     => 'ArrayRef[Patch::Package]',
    traits  => ['Array'],
    default => sub { [] },
    handles => {
        get_all    => 'elements',
        add_item   => 'push',
        next_item  => 'shift',
        map        => 'map',
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

    my @lines = split /\n/, $list;
    foreach my $line (@lines) {
        my ($name, $version, $avail) = split /;/, $line;
        $self->add_item(Patch::Package->new(
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

    $self->map(
        sub {
            print "Package: "    , $_->get_name(),    "\n";
            print "\tVersion: "  , $_->get_version(), "\n";
            print "\tAvailable: ", $_->get_available_version();
            print "\n" x 2;
        });
}


1;
