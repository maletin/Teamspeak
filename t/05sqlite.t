#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

my $n = Teamspeak->new(
  type => 'sql',
  file => 't/server.dbs'
);
$n->connect( '', '' );
ok( defined $n->sl, 'sqlite sl' );
