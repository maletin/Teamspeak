#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

my $n = Teamspeak->new(
  type => 'sql',
  host => 'localhost',
  db   => 'teamspeak'
);
$n->connect( 'teamspeak', 'teamspeak' );
ok( defined $n->sl, 'sql sl' );
