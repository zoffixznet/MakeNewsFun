use strict;
use warnings;

use MakeNewsFun;

my $app = MakeNewsFun->apply_default_middlewares(MakeNewsFun->psgi_app);
$app;

