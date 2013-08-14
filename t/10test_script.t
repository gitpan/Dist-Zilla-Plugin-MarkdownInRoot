# @(#)Ident: 10test_script.t 2013-08-14 16:49 pjf ;

use strict;
use warnings;
use version; our $VERSION = qv( sprintf '0.1.%d', q$Rev: 2 $ =~ /\d+/gmx );
use File::Spec::Functions   qw( catdir catfile updir );
use FindBin                 qw( $Bin );
use lib                 catdir( $Bin, updir, 'lib' );

use Module::Build;
use Test::More;
use Test::DZil;

my $notes = {};

BEGIN {
   my $builder = eval { Module::Build->current };
      $builder and $notes = $builder->notes;
}

my $path = catfile( qw( lib Dist Zilla Plugin MarkdownInRoot.pm ) );

open my $fh, '<', $path or die "File ${path} cannot open: ${!}";

my $content = do { local $/; <$fh> }; close $fh;
my $tzil    = Builder->from_config
   (  { dist_root   => 'lib', },
      { add_files   => {
         'source/lib/Dist/Zilla/Plugin/MarkdownInRoot.pm' => $content,
         'source/dist.ini' =>
            dist_ini( {
               name             => 'Dist-Zilla-Plugin-MarkdownInRoot',
               abstract         => 'Do not care',
               main_module      => 'lib/Dist/Zilla/Plugin/MarkdownInRoot.pm',
               author           => 'E. Xavier Ample <example@example.org>',
               license          => 'Perl_5',
               copyright_holder => 'E. Xavier Ample',
               version          => 'v0.1.1', },
                      'GatherDir', 'MarkdownInRoot::WithMetaLinks' ), }, }, );

$tzil->build; $path = $tzil->root->file( 'README.mkdn' );

open $fh, '<', $path or die "File ${path} cannot open: ${!}";

$content = do { local $/; <$fh> }; close $fh;

like $content,
   qr{ https://metacpan.org/module/Dist::Zilla::Plugin::MarkdownInRoot }mx,
   'Result';

done_testing;

# Local Variables:
# mode: perl
# tab-width: 3
# End:
# vim: expandtab shiftwidth=3:
