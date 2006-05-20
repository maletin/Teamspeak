# $Id$
# $URL$

package Teamspeak::Web;

use 5.004;
use strict;
use Carp;
use WWW::Mechanize;
use vars qw( $VERSION );
$VERSION = '0.3';

sub slogin {
  my ( $self, $login, $password ) = @_;
  my $mech = $self->{mech};
  $mech->follow_link;
  $mech->submit_form( fields => { username => $login, password => $password } )
    or return $self->error('slogin');
  $self->{slogin} = $login;
  $self->{err}    = undef;
  $self->{errstr} = undef;
  return 1;
}    # slogin

sub connect {
  my ( $self, %arg ) = @_;
  my $url  = "http://$self->{w_host}:$self->{w_port}/";
  my $mech = WWW::Mechanize->new;
  $mech->get($url) or return $self->error('connect');
  $self->{mech}    = $mech;
  $self->{connect} = 1;
  $self->login( $arg{login}, $arg{pwd} ) if ( $arg{login} );
  $self->slogin( $arg{slogin}, $arg{pwd} ) if ( $arg{slogin} );
  return 1;    # Success
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

1;
