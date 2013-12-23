#!/usr/bin/env perl

use Catalyst::Test 'MakeNewsFun';
use Test::More tests => 1;

my $out = get('/display/http%3A%2F%2Fwww.sciencedaily.com%2Freleases%2F2013%2F12%2F131220143524.htm');

ok( $out =~ /Science/ );

print "\n\n#####\n\n$out\n";