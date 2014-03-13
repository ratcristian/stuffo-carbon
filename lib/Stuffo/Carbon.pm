package Stuffo::Carbon;

use Mojo::Base 'Mojolicious';

our $VERSION = '1.0';

sub startup {
	my $self = shift();

	$self->secrets( [ 'st4r_tr3k' ] );

	# --- Routes

	$self->routes()
		->post( '/api/put/:config')->to( 
			controller => 'Controllers::Default',
			action => 'put',
		);

	$self->routes()
		->get( '/api/get/:config' )->to(
			controller => 'Controllers::Default',
			action => 'get',
		);

	$self->routes()
		->any( '/api/info/:config' )->to(
			controller => 'Controllers::Default',
			action => 'info',
		);
}

1;