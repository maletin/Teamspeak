#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 2;

my $tsh = Teamspeak->new(
  type => 'sql',
  host => 'localhost',
  db   => 'teamspeak'
);
$tsh->connect( 'teamspeak', 'teamspeak' );
my $c = $tsh->get_channel;
ok( $c->[0]->parameter > 5, 'sql get_channel parameter' );
ok( $c->[0]->store, 'sql channel store' );
