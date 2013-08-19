# @(#)Ident: MarkdownInRoot.pm 2013-08-19 14:19 pjf ;

package Dist::Zilla::Plugin::MarkdownInRoot;

use version; our $VERSION = qv( sprintf '0.1.%d', q$Rev: 5 $ =~ /\d+/gmx );

use Moose;

extends q(Dist::Zilla::Plugin::ReadmeAnyFromPod);

my $config_override = { location => 'root', type => 'markdown', };

# Override the accessors to always return the markdown defaults
for my $method_name (keys %{ $config_override }) {
   around $method_name => sub { return $config_override->{ $method_name } };
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;

__END__

=pod

=encoding utf8

=head1 Name

Dist::Zilla::Plugin::MarkdownInRoot - README.mkdn in the project root with links to Meta::CPAN

=head1 Synopsis

   [MarkdownInRoot::WithMetaLinks]
   filename = README.md

=head1 Version

This documents version v0.1.$Rev: 5 $ of L<Dist::Zilla::Plugin::MarkdownInRoot>

=head1 Description

Creates the F<README.md> file in the project root with hypertext links
pointing to C<metacpan.org> rather than C<search.cpan.org>

Useful for distributions on Github which uses the F<README.md> file in
the project root as a splash page

=head1 Configuration and Environment

Defines the following attributes;

=over 3

=item C<url_prefix>

Defaults to C<https://metacpan.org/module/>

=back

=head1 Subroutines/Methods

=head2 setup_installer

Modifies this base class method. Monkey patches L<Pod::Markdown> to accept
configurable URL prefixes

=head1 Diagnostics

None

=head1 Dependencies

=over 3

=item L<Dist::Zilla::Plugin::ReadmeAnyFromPod>

=back

=head1 Incompatibilities

There are no known incompatibilities in this module

=head1 Bugs and Limitations

There are no known bugs in this module. Please report problems to
http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Plugin-MarkdownInRoot.
Patches are welcome

=head1 Acknowledgements

Larry Wall - For the Perl programming language

=head1 Author

Peter Flanigan, C<< <pjfl@cpan.org> >>

=head1 License and Copyright

Copyright (c) 2013 Peter Flanigan. All rights reserved

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. See L<perlartistic>

This program is distributed in the hope that it will be useful,
but WITHOUT WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE

=cut

# Local Variables:
# mode: perl
# tab-width: 3
# End:
