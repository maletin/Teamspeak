# $Id$
# $URL$

package Teamspeak::Web;

use 5.004;
use strict;
use Carp;
use WWW::Mechanize;
use vars qw( $VERSION );
$VERSION = '0.2';

sub connect {
  my ( $self, %arg ) = @_;
  my $url = "http://$self->{w_host}:$self->{w_port}/";
  my $mech = WWW::Mechanize->new;
  $mech->get( $url );
  $self->{mech} = $mech;
  $self->{connect} = 1;
  $self->{slogin} = '';
  $self->{login} = '';
}    # connect

sub new {
  my ( $class, %arg ) = @_;
  my $s = {
    w_host => $arg{host} || 'localhost',
    w_port => $arg{port} || 14534,
    connected => 0,
  };
  bless $s, ref($class) || $class;
}    # new

sub sl {
  my $self = shift;
  my $s    = 'select * from ts2_servers';
  return $self->{db}->selectall_hashref( $s, 'i_server_id' );
}    # sl

sub my_die {
  croak "my_die";
}    # my_die

1;
