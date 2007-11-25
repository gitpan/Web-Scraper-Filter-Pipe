package Web::Scraper::Filter::Pipe;

use strict;
use warnings;
use Text::Pipe 'PIPE';


our $VERSION = '0.01';


use base qw(Exporter);


our @EXPORT = qw(PIPE_);


# Takes same args as PIPE()

sub PIPE_ { PIPE(@_)->as_scraper_filter }


# return a coderef to be used with Web::Scraper's filter mechanism
    
sub Text::Pipe::Base::as_scraper_filter {
    my $self = shift;
    sub { $self->filter($_) };
}


1;


__END__



=head1 NAME

Web::Scraper::Filter::Pipe - Web::Scraper filter to use Text::Pipe segments

=head1 SYNOPSIS

    use Web::Scraper;
    use Web::Scraper::Filter::Pipe;

    my $s = scraper {
        process 'a', want =>
            ['TEXT', PIPE_('Uppercase'), PIPE_('Repeat', join => '**') ];
        result 'want';
    };
    my $want = $s->scrape('<a>foo</a>');   # $want is 'FOO**FOO'

=head1 DESCRIPTION

This is a a filter for L<Web::Scraper> that lets you use L<Text::Pipe> pipe
segments as filters.

It exports a function, C<PIPE_()>, that takes the same arguments as
L<Text::Pipe>'s C<PIPE()> or as its constructor, C<new()>, that is, the pipe
segment type and an optional hash of named arguments. Note the underscore at
the end of the function name; it says that this is like C<PIPE()>, but returns
a coderef that acts on C<$_> - which is what Web::Scraper expects of a filter.

See each individual pipe segment type for whether it takes arguments and if
so, which ones.

Note that you have to manually bring in this package because the Web::Scraper
filter mechanism only takes a string denoting a filter class or a coderef, but
it's not possible to pass arguments to the filter class. Viewed this way, this
package isn't really a filter, more like a filter generator. Ideas to make the
API more elegant are welcome, or maybe one day Web::Scraper will allow
arguments to be passed to the filter class' constructor.

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<webscraperfilterpipe> tag.

=head1 VERSION 
                   
This document describes version 0.01 of L<Web::Scraper::Filter::Pipe>.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<<bug-web-scraper-filter-pipe@rt.cpan.org>>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

