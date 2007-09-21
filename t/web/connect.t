#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

my $tsh = Teamspeak->new( type => 'web' );
ok( $tsh->connect( slogin => 'sa', pwd => 'sa' ), 'connect' );
