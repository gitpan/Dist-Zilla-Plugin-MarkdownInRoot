# @(#)Ident: 05kwalitee.t 2013-08-14 14:55 pjf ;

use strict;
use warnings;
use version; our $VERSION = qv( sprintf '0.2.%d', q$Rev: 1 $ =~ /\d+/gmx );
use File::Spec::Functions;
use FindBin qw( $Bin );
use lib catdir( $Bin, updir, q(lib) );

use English qw(-no_match_vars);
use Test::More;

BEGIN {
   $ENV{AUTHOR_TESTING} or plan skip_all => 'Kwalitee test only for developers';
}

eval { require Test::Kwalitee; };

$EVAL_ERROR and plan skip_all => 'Test::Kwalitee not installed';

# Since we now use a custom Moose exporter this metric is no longer valid
Test::Kwalitee->import( tests =>
                        [ qw( -has_test_pod_coverage -use_strict ) ] );

unlink q(Debian_CPANTS.txt);

# Local Variables:
# mode: perl
# tab-width: 3
# End:
