# $Id$
# $URL$

package Teamspeak::SQL;

use 5.004;
use strict;
use Carp;
use DBI;
use vars qw( $VERSION );
$VERSION = '0.1';
my @ISA = qw( Teamspeak );

sub connect {
  my ( $self, $user, $pwd ) = @_;
  my $dsn = "dbi:mysql:database=$self->{d_db}";
  $dsn .= ";hostname=$self->{d_host};port=$self->{d_port}";
  my $m = DBI->connect( $dsn, $user, $pwd );
  $self->{db} = $m;
}    # connect

sub new {
  my ( $class, %arg ) = @_;
  bless {
    d_host => $arg{host} || 'localhost',
    d_port => $arg{port} || 3306,
    d_db   => $arg{db}   || 'teamspeak',
    },
    ref($class) || $class;
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
