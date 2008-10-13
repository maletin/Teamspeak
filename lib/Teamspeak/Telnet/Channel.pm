# $Id$
# $URL$

package Teamspeak::Telnet::Channel;

use strict;
use base 'Teamspeak::Channel';

my @_parameters = (
    'id',    'name',     'topic',    'parent',
    'flags', 'maxusers', 'password', 'order'
);

sub parameter {
    return @_parameters;
}

sub new {
    my ( $class, %arg ) = @_;
    bless {
        id       => $arg{id},
        parent   => $arg{parent},
        order    => $arg{order},
        maxusers => $arg{maxusers},
        name     => $arg{name},
        flags    => $arg{flags},
        password => $arg{password},
        topic    => $arg{topic},
        },
        ref($class) || $class;
}    # new

sub id {
    my $self = shift;
    return $self->{id};
}

sub codec {
    my $self = shift;
    return $self->{codec};
}

sub parent {
    my $self = shift;
    return $self->{parent};
}

sub order {
    my $self = shift;
    return $self->{order};
}

sub maxusers {
    my $self = shift;
    return $self->{maxusers};
}

sub name {
    my $self = shift;
    return $self->{name};
}

sub flags {
    my $self = shift;
    return $self->{flags};
}

sub password {
    my $self = shift;
    return $self->{password};
}

sub topic {
    my $self = shift;
    return $self->{topic};
}    # topic

1;

__END__

=head1 NAME

Teamspeak::Telnet::Channel - Datastructure for a Teamspeak-Channel.

=head2 parameter()

=head2 new()

=head2 id()

=head2 codec()

=head2 parent()

=head2 order()

=head2 maxusers()

=head2 name()

=head2 flags()

=head2 password()

=head2 topic()

=cut
