# @(#)Ident: WithMetaLinks.pm 2013-08-14 13:30 pjf ;

package Dist::Zilla::Plugin::MarkdownInRoot::WithMetaLinks;

use version; our $VERSION = qv( sprintf '0.1.%d', q$Rev: 2 $ =~ /\d+/gmx );

use Moose;

extends q(Dist::Zilla::Plugin::MarkdownInRoot);

has 'url_prefix' => is => 'ro', isa => 'Str',
   default       => 'https://metacpan.org/module/';

around 'setup_installer' => sub {
   my ($orig, $self, @args) = @_;

   $Dist::Zilla::Plugin::ReadmeAnyFromPod::_types->{markdown}->{parser}
      = $self->_setup_parser;

   return $orig->( $self, @args );
};

sub _setup_parser {
   my $self = shift; my $url_prefix = $self->url_prefix;

   return sub {
      my $content = $_[ 0 ]; require IO::Scalar; require Pod::Markdown;

      # Monkey patch Pod::Markdown to allow for configurable URL prefixes
      no warnings 'redefine'; *Pod::Markdown::_resolv_link = \&_my_resolve_link;

      my $parser = Pod::Markdown->new( url_prefix => $url_prefix );

      $parser->parse_from_filehandle( IO::Scalar->new( \$content ) );

      return $parser->as_markdown();
   }
}

sub _my_resolve_link {
   my ($self, $cmd, $arg) = @_; local $self->_private->{InsideLink} = 1;

   my ($text, $inferred, $name, $section, $type) =
      map { $_ && $self->interpolate( $_, 1 ) }
      Pod::ParseLink::parselink( $arg );
   my $url = q();

   if    ($type eq q(url)) { $url = $name }
   elsif ($type eq q(man)) {
      my ($page, $part) = $name =~ m{ \A ([^\(]+) (?:[\(] (\S*) [\)])? }mx;
      my $prefix = $self->{man_prefix} || 'http://man.he.net/man';

      $url = $prefix.($part || 1).'/'.($page || $name);
   }
   else {
      my $prefix = $self->{url_prefix} || 'http://search.cpan.org/perldoc?';

      $name    and $url  = "${prefix}${name}";
      $section and $url .= "#${section}";
   }

   $url and return sprintf '[%s](%s)', ($text || $inferred), $url;

   return sprintf '%s<%s>', $cmd, $arg;
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;

__END__

# Local Variables:
# mode: perl
# tab-width: 3
# End:
