#!perl -T

use Test::More tests => 4;

BEGIN {
	use_ok( 'Catalyst::Plugin::Authentication::AuthTkt' );
	use_ok( 'Catalyst::Plugin::Authentication::Credential::AuthTkt' );
	use_ok( 'Catalyst::Plugin::Authentication::Store::AuthTkt' );
	use_ok( 'Catalyst::Plugin::Authentication::User::AuthTkt' );
}

diag( "Testing Catalyst::Plugin::Authentication::AuthTkt $Catalyst::Plugin::Authentication::AuthTkt::VERSION, Perl $], $^X" );
