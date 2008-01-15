package Catalyst::Plugin::Authentication::Store::AuthTkt;

use warnings;
use strict;
use base qw( Class::Accessor::Fast );
use Apache::AuthTkt 0.07;
use Carp;
use Data::Dump qw( dump );
use Catalyst::Plugin::Authentication::User::AuthTkt;

__PACKAGE__->mk_accessors(qw( cookie_name ticket ));

our $VERSION = '0.01';

=head1 NAME

Catalyst::Plugin::Authentication::AuthTkt - shim for Apache::AuthTkt

=head1 DESCRIPTION

This module implements the Catalyst::Plugin::Authentication API for Apache::AuthTkt.
See Catalyst::Plugin::Authentication::AuthTkt for complete user documentation.

=head1 METHODS

=cut

=head2 new( I<config>, I<app> )

Instantiate the store. I<config> is used to set the cookie name to check in find_user().

=cut

sub new {
    my ( $class, $config, $app ) = @_;
    my $self = $class->SUPER::new(
        { cookie_name => $config->{cookie_name} || 'auth_tkt' } );
    if ( $config->{conf} ) {
        $self->{ticket} = Apache::AuthTkt->new( conf => $config->{conf} );
    }
    elsif ( $config->{secret} ) {
        $self->{ticket} = Apache::AuthTkt->new( secret => $config->{secret} );
    }
    else {
        croak "conf or secret configuration required";
    }
    return $self;
}

=head2 find_user( I<userinfo>, I<context> )

Returns a Catalyst::Plugin::Authentication::User::AuthTkt object on success,
undef on failure.

find_user() checks the I<context> request object for a cookie named cookie_name()
or a param named cookie_name(), in that order. If neither are present, or if
present but invalid, find_user() returns undef.

=cut

sub find_user {
    my ( $self, $userinfo, $c ) = @_;

    # if no cookie or param, return undef
    my $cookie = $c->req->cookie( $self->cookie_name )
        || $c->req->params->{ $self->cookie_name };
    unless ($cookie) {
        $c->log->debug( "No cookie or param for " . $self->cookie_name )
            if $c->debug;
        return;
    }

    # unpack cookie
    my $parsed = $self->ticket->parse_ticket(
        ref($cookie) ? $cookie->value : $cookie );
    unless ($parsed) {
        return;
    }

    $c->log->debug( dump($parsed) ) if $c->debug;

    # return user object
    return Catalyst::Plugin::Authentication::User::AuthTkt->new(
        {   id     => $parsed->{uid},
            data   => $parsed->{data},
            tokens => [ split( m/\s*,\s*/, $parsed->{tokens} || '' ) ]
        }
    );

}

=head2 for_session( I<context>, I<user> )

Implements required method for stashing I<user> in a session.

=cut

sub for_session {
    my ( $self, $c, $user ) = @_;
    return $user;    # we serialize the whole user
}

=head2 from_session( I<context>, I<frozen_user> )

Implements required method for de-serializing I<frozen_user> from a session store.

=cut

sub from_session {
    my ( $self, $c, $frozen_user ) = @_;
    return $frozen_user;
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
