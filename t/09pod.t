#!/usr/bin/perl -w
# $Id$
# $URL$

use strict;
use Teamspeak;
use Test::More;

#eval 'use Test::Pod 1.00';
#plan( skip_all => 'Test::Pod 1.00 required for testing POD' ) if $@;
#all_pod_files_ok();

eval 'use Test::Pod::Coverage 1.04';
plan( skip_all => 'Test::Pod::Coverage 1.04 required for testing POD coverage') if $@;
all_pod_coverage_ok( );
