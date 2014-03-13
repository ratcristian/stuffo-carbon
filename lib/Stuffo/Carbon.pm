package Stuffo::Carbon;

use Mojo::Base 'Mojolicious';

our $VERSION = '1.0';

sub startup {
	my $self = shift();

	# --- Routes

	$self->routes()
		->post( '/api/put/:config')->to( 
			controller => 'Controllers::Default',
			action => 'put',
		);

	$self->routes()
		->any( '/api/get/:config' )->to(
			controller => 'Controllers::Default',
			action => 'info',
		);
}

1;