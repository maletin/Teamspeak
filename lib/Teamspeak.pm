# $Id$
# $URL$

package Teamspeak;

use 5.004;
use strict;
use Net::Telnet;
use vars qw( $VERSION );
use Teamspeak::Telnet;
use Teamspeak::SQL;

$VERSION = '0.2';

sub new {
  my ( $class, %arg ) = @_;
  if ( $arg{type} eq 'telnet' ) {
    return Teamspeak::Telnet->new(%arg);
  } elsif ( $arg{type} eq 'sql' ) {
    return Teamspeak::SQL->new(%arg);
  } else {
    die("unknown type $arg{type}");
  }
}    # new

1;

__END__

=head1 NAME

Teamspeak - Interface to administrate Teamspeak-Server.

=head1 SYNOPSIS

 use Teamspeak;
 my $t = Teamspeak->new( 
     timeout => <sec>,
     port => <port_number>,
     host => <ip_or_hostname>
   );
 
=head1 DESCRIPTION

You can connect to a Teamspeak-Server in four different ways:
  1. Telnet
  2. MySQL or MySQL::Lite
  3. Web-Frontend
  4. Teamspeak-Client is using UDP

Every Method can only administrate a part of all Methods together.

=head1 DIAGNOSTICS

The Project is still Pre-Alpha.

=head1 AUTHOR

Martin von Oertzen (maletin@cpan.org)

=head1 BUGS AND IRRITATIONS

There are undoubtedly serious bugs lurking somewhere in this code, if
only because parts of it give the impression of understanding a great deal
more about Perl than they really do. 

Bug reports and other feedback are most welcome.

=head1 COPYRIGHT

Copyright (c) 2005-2005, Martin von Oertzen. All Rights Reserved.
This module is free software. It may be used, redistributed
and/or modified under the same terms as Perl itself.
