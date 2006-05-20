#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

my $tsh = Teamspeak->new( type => 'telnet' );
$tsh->connect();
ok( $tsh->sl == 2, 'two servers' );
