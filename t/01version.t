#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::Simple tests => 1;

ok( $Teamspeak::VERSION > 0, 'version is positive' );
