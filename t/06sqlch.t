#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 2;

my $n = Teamspeak->new(
  type => 'sql',
  host => 'localhost',
  db   => 'teamspeak'
);
$n->connect( 'teamspeak', 'teamspeak' );
my $c = $n->get_channel;
ok( $c->[0]->parameter > 5, 'sql get_channel parameter' );
ok( $c->[0]->store, 'sql channel store' );
