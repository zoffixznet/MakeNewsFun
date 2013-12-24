package MakeNewsFun::Controller::Root;
use Moose;

use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller' }


__PACKAGE__->config(namespace => '');


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub display :Local :Args(1){
    my ( $self, $c, $url ) = @_;

    $c->stash( zstory =>$c->model('LWP')->make_news( $url ) );
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}


sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;
