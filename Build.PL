# @(#)$Ident: DZ_Build.PL 2013-08-25 12:52 pjf ;

use strict;
use warnings;

use Module::Build;

sub whimper { print {*STDOUT} $_[ 0 ]."\n"; exit 0 }

my $mb_ver   = 0.4004;
my $perl_ver = 5.008;
my $name     = 'Dist-Zilla-Plugin-MarkdownInRoot'; $name =~ s{ - }{::}gmx;

$] >= $perl_ver or $ENV{PERL5_CPANPLUS_IS_VERSION}
   or whimper "Minimum required Perl version is ${perl_ver}";

eval { Module::Build->VERSION( $mb_ver ) }
   or whimper "Minimum required Module::Build version is ${mb_ver}";

Module::Build->subclass( code => do { local $/; <DATA> } )->new(
  'module_name' => $name,
  'notes'       => { min_perl_version => $perl_ver },
  'build_requires' => {
    'Module::Build' => '0.4004',
    'version' => '0.88'
  },
  'configure_requires' => {
    'Module::Build' => '0.4004',
    'version' => '0.88'
  },
  'requires' => {
    'Dist::Zilla::Plugin::ReadmeAnyFromPod' => '0.133290',
    'IO::Stringy' => '2.110',
    'Moose' => '2.0802',
    'Pod::Markdown' => '1.322',
    'perl' => '5.008'
  },

)->create_build_script;

exit 0;

__DATA__

sub _normalize_prereqs { # Dynamic config
   my $self = shift; my $p = $self->SUPER::_normalize_prereqs; return $p;
}
