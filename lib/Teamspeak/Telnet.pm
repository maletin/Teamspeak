# $Id$
# $URL$

package Teamspeak::Telnet;

use 5.004;
use strict;
use Carp;
use vars qw( $VERSION );
$VERSION = '0.2';
my @ISA = qw( Teamspeak );

## Module import.
use Net::Telnet;

sub connect {
  my $self = shift;
  my $t = Net::Telnet->new( Timeout => $self->{timeout} );
  my_die("can't create Telnet-Instance") if ( !$t );
  $t->open( Host => $self->{host}, Port => $self->{port} )
    or my_die( $t->errmsg );
  my @answer = $t->waitfor('/\[TS\]$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  $self->{sock}   = $t;
}    # connect

sub new {
  my ( $class, %arg ) = @_;
  bless {
    host    => $arg{host}    || 'localhost',
    port    => $arg{port}    || 51234,
    timeout => $arg{timeout} || 4,
    },
    ref($class) || $class;
}    # new

# Server List:
sub sl {
  my $self = shift;
  $self->{sock}->print('sl');
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return @answer;
}

# Select Server:
sub sel {
  my ( $self, $server_id ) = @_;
  $self->{sock}->print("sel $server_id");
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return 1;
}    # sel

# Superadmin LOGIN:
sub slogin {
  my ( $self, $login, $pwd ) = @_;
  $self->{sock}->print("slogin $login $pwd");
  $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return 1;
}    # slogin

# normal LOGIN:
sub login {
  my ( $self, $login, $pwd ) = @_;
  $self->{sock}->print("login $login $pwd");
  $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return 1;
}    # login

# Database userlist:
sub dbuserlist {
  my $self   = shift;
  my @result = ();
  my_die("command needs login") if !logged_in();
  $self->{sock}->print('dbuserlist');
  my @answer = $self->{sock}->waitfor('/OK$/');
  pop @answer;  # Last Line contains OK
  my @lines = split( /\cJ/, "@answer" );
  shift @lines; # First Line is empty
  my $fields = shift @lines;
  my @fields = split( /\cI/, $fields );
  foreach my $line (@lines) {
    my @r = split( /\cI/, $line );
    my %args = map {
      $r[$_] =~ s/^"(.*)"$/$1/;
      $r[$_] =~ s/^(\d\d)-(\d\d)-(\d{4})/$3-$2-$1/;
      $fields[$_] => $r[$_] } 0..@r-1;
    push( @result, { %args } );
  }
  return @result;
}    # dbuserlist

# Database userdelete:
sub delete_user {
  my ( $self, $user_id ) = @_;
  $self->{sock}->print("dbuserdel $user_id");
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return 1;
}    # delete_user

# Database useradd:
sub add_user {
  my ( $self, %args ) = @_;
  $args{admin} = 0 if $args{admin} != 1;
  $self->{sock}->print("dbuseradd $args{user} $args{pwd} $args{pwd} $args{admin}");
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return 1;
}    # add_user

# Channel List:
sub cl {
  my $self = shift;
  $self->{sock}->print('cl');
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return @answer;
}    # cl

# Player List:
sub pl {
  my $self = shift;
  $self->{sock}->print('pl');
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return @answer;
}    # pl

# QUIT:
sub quit {
  my $self = shift;
  $self->{sock}->print('quit');
  delete $self->{sock};
}

sub my_die {
  croak "my_die";
}

sub logged_in {
  1;    #TODO
}

1;
