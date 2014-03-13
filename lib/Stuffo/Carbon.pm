package Stuffo::Carbon;

use Mojo::Base 'Mojolicious';

our $VERSION = '1.0';

sub startup {
	my $self = shift();

	# --- Routes

	$self->routes()
		->post( '/api/copy/:config')->to( 
			controller => 'Controllers::Default',
			action => 'copy',
		);

	$self->routes()
		->any( '/api/info/:config' )->to(
			controller => 'Controllers::Default',
			action => 'info',
		);
}

1;