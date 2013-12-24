package MakeNewsFun::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    # WRAPPER => 'wrapper.tt',
);


=head1 NAME

MakeNewsFun::View::HTML - TT View for MakeNewsFun

=head1 DESCRIPTION

TT View for MakeNewsFun.

=head1 SEE ALSO

L<MakeNewsFun>

=head1 AUTHOR

Zoffix Znet,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
