#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

my $n = Teamspeak->new( type => 'web' );
ok( $n->connect( slogin => 'sa', pwd => 'sa' ), 'connect' );
