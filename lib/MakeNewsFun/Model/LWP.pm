package MakeNewsFun::Model::LWP;
use Moose;
use LWP::UserAgent;
use utf8;
use HTML::TokeParser::Simple;
use namespace::autoclean;
use URI;
use URI::Escape;

extends 'Catalyst::Model';


sub make_news {
    my $self = shift;
    my $url  = URI->new( shift );

    my $ua = LWP::UserAgent->new(
        agent => 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:26.0) '
            . 'Gecko/20100101 Firefox/26.0'
    );

    my $res = $ua->get( $url );

    if ( $res->is_success ) {
        return __process_story( $url, $res->decoded_content );
    }
    else {
        return '[ERROR]: ' . $res->status_line;
    }
}

sub __process_story {
    my ( $url, $html ) = @_;

    my $p = HTML::TokeParser::Simple->new( \ $html );
    my $out_html = '';
    my $subs = ___subs();

    my $domain = join '', $url->scheme, '://', $url->authority;
    while ( my $token = $p->get_token ) {
        unless ( $token->is_text ) {
            if ( $token->is_tag('a') and defined $token->get_attr('href')
            ) {
                my $new_url
                = uri_escape
                    $url->new( $token->get_attr('href') )->abs( $domain );

                $token->set_attr(
                    'href',
                    'http://0:3000/?url=' . $new_url
                );
            }

            $out_html .= $token->as_is;
            next;
        }

        my $v = $token->as_is;
        $v =~ s/($_)/preserve_case($1, $subs->{$_})/egi
            for keys %$subs;

        $out_html .= $v;
    }

    return "<base href='$url'>" . $out_html;
}

sub preserve_case {
    my ($from, $to) = @_;
    my ($lf, $lt) = map length, @_;

    if ($lt < $lf) { $from = substr $from, 0, $lt }
    else { $from .= substr $to, $lf }

    return uc $to | ($from ^ uc $from);
}


sub ___subs {
    return +{
        witnesses       => 'these dudes I know',
        allegedly       => 'kinda probably',
        'new study'     => 'tumblr post',
        rebuild         => 'avenge',
        space           => 'spaaace',
        'google glass'  => 'virtual boy',
        smartphone      => 'pokédex',
        electric        => 'atomic',
        senator         => 'elf-lord',
        car             => 'cat',
        election        => 'eating contest',
        'congressional leaders' => 'river spirits',
        'homeland security' => 'homestar runner',
        'could not be reached for comment' => 'is guilty and everyone knows it',
    };
}

__PACKAGE__->meta->make_immutable;

1;
