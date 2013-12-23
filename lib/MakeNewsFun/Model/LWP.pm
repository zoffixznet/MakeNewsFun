package MakeNewsFun::Model::LWP;
use Moose;
use LWP::UserAgent;
use namespace::autoclean;


extends 'Catalyst::Model';


sub make_news {
    my ( $self, $url ) = @_;

    my $ua = LWP::UserAgent->new(
        agent => 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:26.0) '
            . 'Gecko/20100101 Firefox/26.0'
    );

    my $res = $ua->get( $url );

    if ( $res->is_success ) {
        return "<base href='$url'>" . $res->decoded_content;
    }
    else {
        return '[ERROR]: ' . $res->status_code . ' ' . $res->status_line;
    }
}

__PACKAGE__->meta->make_immutable;

1;
