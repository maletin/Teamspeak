#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

my $n = Teamspeak->new( type => 'telnet' );
$n->connect();
ok( $n->sl == 2, 'two servers' );
