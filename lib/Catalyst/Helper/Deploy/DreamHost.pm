package Catalyst::Helper::Deploy::DreamHost;

# ABSTRACT: The great new Catalyst::Helper::Deploy::DreamHost!

use Moose;
use namespace::autoclean;
use common::sense;


__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

In C<dist.ini>:

    [NoSmartCommentsTests]

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following file:

    xt/release/no-smart-comments.t - test to ensure no Smart::Comments

=head1 NOTE

The name of this plugin has turned out to be somewhat misleading, I'm afraid:
we don't actually test for the _existance_ of smart comments, rather we
ensure that Smart::Comment is not used by any file checked.

=head1 SEE ALSO

L<Smart::Comments>, L<Test::NoSmartComments>

=head1 BUGS

All complex software has bugs lurking in it, and this module is no exception.

Please report any bugs to
"bug-Catalyst::Helper::Deploy::DreamHost@rt.cpan.org",
or through the web interface at <http://rt.cpan.org>.

Patches and pull requests through GitHub are most welcome; our page and repo
(same URI):

    https://github.com/RsrchBoy/Catalyst::Helper::Deploy::DreamHost

=cut

