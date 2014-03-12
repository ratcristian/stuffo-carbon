package Stuffo::Carbon;

use Mojo::Base 'Mojolicious';

our $VERSION = '1.0';

sub startup {
	my $self = shift();

	$self->routes()
		->post( '/api/:config')->to( 
			controller => 'Stuffo::Carbon::Controllers::Default', 
			action => 'index',
		);
}

1;