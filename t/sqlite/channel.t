#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 3;

my $ths = Teamspeak->new(
  type => 'sql',
  file => 't/sqlite/server.dbs'
);
$ths->connect( '', '' );
ok( defined $ths->sl, 'sqlite sl' );
ok( my $ch_list = $ths->get_channel(), 'get_channel' );
my @cmd        = Teamspeak::Channel->parameter;
my $can_method = 1;
foreach my $ch ($ch_list) {

  foreach my $cmd (@cmd) {
    $can_method = 0 if ( !$ths->{channel}{$ch}->can($cmd) );
  }
}
ok( $can_method, 'ch methods' );
