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

# DataBase USERLIST:
sub dbuserlist {
  my $self   = shift;
  my @result = ();
  my_die("command needs login") if !logged_in();
  $self->{sock}->print('dbuserlist');
  my @answer = $self->{sock}->waitfor('/OK$/');
  foreach my $line (@answer) {
    my @r = split( /\t/, $line );
    push( @result, [@r] );
  }
  return @result;
}    # dbuserlist

# DataBase USERDELete:
sub dbuserdel {
  my ( $self, $user_id ) = @_;
  $self->{sock}->print("dbuserdel $user_id");
  my @answer = $self->{sock}->waitfor('/OK$/');
  $self->{err}    = 0;
  $self->{errmsg} = undef;
  return 1;
}    # dbuserdel

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
}    # cl

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
