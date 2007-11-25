#!/usr/bin/env perl

use warnings;
use strict;
use Web::Scraper;
use Test::Base;
plan tests => 1 * blocks;

package Test::Base::Filter;
use Web::Scraper::Filter::Pipe 'PIPE_';

package main;

filters {
    expected => 'chomp',
    want => 'eval',
};

run {
    my $block = shift;
    my $s = scraper {
        process 'a', want => $block->want;
        result 'want';
    };
    my $want = $s->scrape('<a>foo</a>');
    my $expected = $block->expected eq 'undef' ? undef : $block->expected;

    is $want, $expected, $block->name;
};

package main;

__DATA__

=== Uppercase
--- want
['TEXT', PIPE_('Uppercase') ]
--- expected
FOO

=== Uppercase + Reverse
--- want
['TEXT', PIPE_('Uppercase'), PIPE_('Reverse') ]
--- expected
OOF
