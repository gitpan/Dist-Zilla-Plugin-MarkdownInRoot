# @(#)$Ident: Build.PL 2013-08-14 14:45 pjf ;

use strict;
use warnings;

use Module::Build;

sub whimper { print {*STDOUT} $_[ 0 ]."\n"; exit 0 }

my $code = do { local $/; <DATA> }; my $perl_ver = 5.008;

$] >= $perl_ver or whimper "Minimum required Perl version is ${perl_ver}";

Module::Build->subclass( code => $code )->new(
  'module_name' => 'Dist::Zilla::Plugin::MarkdownInRoot',
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
    'Dist::Zilla::Plugin::ReadmeAnyFromPod' => '0.120120',
    'Moose' => '2.0802'
  },

)->create_build_script;

exit 0;

__DATA__

sub _normalize_prereqs { # Dynamic config
   my $self = shift; my $p = $self->SUPER::_normalize_prereqs; return $p;
}
