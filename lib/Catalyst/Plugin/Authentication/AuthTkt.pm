package Catalyst::Plugin::Authentication::AuthTkt;

use warnings;
use strict;

our $VERSION = '0.02';

=head1 NAME

Catalyst::Plugin::Authentication::AuthTkt - **DEPRECATED** shim for Apache::AuthTkt

=head1 SYNOPSIS

    use Catalyst qw(
        Authentication
    );

    # Configure an authentication realm in your app config:
    authentication:
        default_realm: 'external'
        realms:
            external:
                credential:
                    class: 'AuthTkt'
                store:
                    class: 'AuthTkt'
                    cookie_name: auth_tkt
                    conf: path/to/httpd.conf
                    # or use the secret string explicitly
                    secret: fee fi fo fum

    # and then in your Root controller 'auto':
    sub auto : Private {
        my ( $self, $c ) = @_;
        $c->authenticate;
        if ($c->user_exists) {
            return 1;
        }
        else {
            $c->response->redirect( $c->config->{authentication_url} );
            return 0;
        }
    }

    # and then later on
    if ($c->user_exists) {
      $c->log->debug("Logged in as user " . $c->user->id);
      ...
    }

=head1 DESCRIPTION

B<THIS MODULE IS DEPRECATED. See Catalyst::Authentication::AuthTkt instead.>

This module implements the Catalyst::Plugin::Authentication API for Apache::AuthTkt version 0.08 and later.

B<This module does not implement any features for creating the AuthTkt cookie.>
Instead, this module simply checks that the AuthTkt cookie is present and unpacks it
in accordance with the Authentication API. The intention is that you create/set the AuthTkt cookie
independently of the Authentication code, whether in a separate application (e.g. the mod_auth_tkt
C<login.cgi> script) or via the Apache::AuthTkt module directly.

mod_auth_tkt L<http://www.openfusion.com.au/labs/mod_auth_tkt/> is a single-sign-on C module for Apache.
Using this module, however, you could implement all the features of mod_auth_tkt, in Perl, using any
web server where you can deploy Catalyst, including front-end-proxy/back-end-mod_perl and lighttpd situations.

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

1; # End of Catalyst::Plugin::Authentication::AuthTkt
