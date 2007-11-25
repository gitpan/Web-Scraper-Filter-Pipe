#!/usr/bin/env perl

use warnings;
use strict;
use Web::Scraper::Filter::Pipe 'PIPE_';
use Test::More tests => 56;


sub pipe_ok {
    my ($spec, $input, $expect, $testname) = @_;
    $spec = [ $spec ] unless ref $spec eq 'ARRAY';
    my $type = $spec->[0];

    $testname = '' unless defined $testname;
    $testname = "$type $testname: $input";
    $testname =~ s/\n/\\n/g;

    local $_ = $input;
    my $filter = PIPE_(@$spec);
    is(ref $filter, 'CODE', 'PIPE_ returned a coderef');
    is($filter->(), $expect, "PIPE_ $testname");

    $filter = Text::Pipe->new(@$spec)->as_scraper_filter;
    is(ref $filter, 'CODE', 'as_scraper_filter() returned a coderef');
    is($filter->(), $expect, "as_scraper_filter() $testname");

}


pipe_ok('Trim', '  a test  ', 'a test');
pipe_ok('Uppercase', 'a test', 'A TEST');
pipe_ok([ 'Repeat', times => 2, join => ' = ' ], 'A TEST', 'A TEST = A TEST');
pipe_ok('Reverse', 'a test', 'tset a');

pipe_ok('Append', 'a test', 'a test', 'empty');
pipe_ok([ 'Append', text => 'foobar' ], 'a test', 'a testfoobar', 'text');

pipe_ok('Prepend', 'a test', 'a test', 'empty');
pipe_ok([ 'Prepend', text => 'foobar' ], 'a test', 'foobara test', 'text');

pipe_ok('Chop', "a test\n", 'a test', 'newline');
pipe_ok('Chop', 'a test', 'a tes', 'non-newline');

pipe_ok('Chomp', "a test\n", 'a test', 'newline');
pipe_ok('Chomp', 'a test', 'a test', 'non-newline');

pipe_ok('UppercaseFirst', 'test', 'Test');
pipe_ok('LowercaseFirst', 'TEST', 'tEST');

