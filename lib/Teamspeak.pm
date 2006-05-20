# $Id$
# $URL$

package Teamspeak;
use Teamspeak::Channel;
use Teamspeak::Player;

use 5.004;
use strict;
use Net::Telnet;
use Carp;
use vars qw( $VERSION );

$VERSION = '0.3';

sub new {
  my ( $class, %arg ) = @_;
  if ( $arg{type} eq 'telnet' ) {
    require Teamspeak::Telnet;
    return Teamspeak::Telnet->new(%arg);
  } elsif ( $arg{type} eq 'sql' ) {
    require Teamspeak::SQL;
    return Teamspeak::SQL->new(%arg);
  } elsif ( $arg{type} eq 'web' ) {
    require Teamspeak::Web;
    return Teamspeak::Web->new(%arg);
  } else {
    die("unknown type $arg{type}");
  }
}    # new

sub error {
  $_[0]->{err}    = 1;
  $_[0]->{errstr} = $_[1];
  return 0;
}    # error

sub my_die {
  croak "my_die";
}    # my_die

1;

__END__

=head1 NAME

Teamspeak - Interface to administrate Teamspeak-Server.

=head1 VERSION

This document refers to version 0.3 of Teamspeak.

=head1 SYNOPSIS

 use Teamspeak;
 my $t = Teamspeak->new( 
     timeout => <sec>,
     port => <port_number>,
     host => <ip_or_hostname>
   );
 
=head1 DESCRIPTION

You can connect to a Teamspeak-Server in four different Connection-Types:
  1. Telnet
  2. MySQL or MySQL::Lite
  3. Web-Frontend
  4. Teamspeak-Client is using UDP

Every Connection-Type can only use a part of all available Methods.

=head2 Overview

=head2 Constructor and initialization

=head2 Class and object methods

=head1 ENVIRONMENT

There are no Environment-Variables used, at the moment.

=head1 DIAGNOSTICS

The Project is still Pre-Alpha.

=over 4

=item Can't locate Teamspeak.pm in @INC

=back

=head1 BUGS

There are undoubtedly serious bugs lurking somewhere in this code, if
only because parts of it give the impression of understanding a great deal
more about Perl than they really do. 

Bug reports and other feedback are most welcome at
http://rt.cpan.org/NoAuth/Dists.html?Queue=Teamspeak

=head1 FILES

=head1 SEE ALSO

Teamspeak::Core    Data-Structures for all Interfaces.
Teamspeak::Telnet  The Telnet-Interface.
Teamspeak::SQL     The SQL-Interface.
Teamspeak::Web     The Web-Interface.

=head1 AUTHOR

Martin von Oertzen (maletin@cpan.org)

=head1 COPYRIGHT

Copyright (c) 2005-2005, Martin von Oertzen. All Rights Reserved.
This module is free software. It may be used, redistributed
and/or modified under the same terms as Perl itself.
