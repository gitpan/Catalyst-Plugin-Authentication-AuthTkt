package Catalyst::Plugin::Authentication::Credential::AuthTkt;

use warnings;
use strict;
use base qw( Class::Accessor::Fast );

our $VERSION = '0.01';

=head1 NAME

Catalyst::Plugin::Authentication::AuthTkt - shim for Apache::AuthTkt

=head1 DESCRIPTION

This module implements the Catalyst::Plugin::Authentication API for Apache::AuthTkt.
See Catalyst::Plugin::Authentication::AuthTkt for complete user documentation.

=head1 METHODS

=head2 authenticate( I<context>, I<authstore>, I<authinfo> )


=cut

sub authenticate {
    my ( $self, $c, $authstore, $authinfo ) = @_;
    my $user_obj = $authstore->find_user( $authinfo, $c );
    return ref $user_obj ? $user_obj : undef;
}

=head1 AUTHOR

Peter Karman, C<< <karman at cpan dot org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-catalyst-plugin-authentication-authtkt at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Plugin-Authentication-AuthTkt>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Plugin::Authentication::AuthTkt

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Plugin-Authentication-AuthTkt>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Plugin-Authentication-AuthTkt>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Plugin-Authentication-AuthTkt>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Plugin-Authentication-AuthTkt>

=back

=head1 ACKNOWLEDGEMENTS

The Minnesota Supercomputing Institute C<< http://www.msi.umn.edu/ >>
sponsored the development of this software.

=head1 COPYRIGHT & LICENSE

Copyright 2007 by the Regents of the University of Minnesota.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1;    # End of Catalyst::Plugin::Authentication::AuthTkt
