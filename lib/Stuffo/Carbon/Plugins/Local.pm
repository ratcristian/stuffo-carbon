package Stuffo::Carbon::Plugins::Local;

use Moose;

extends 'Stuffo::Carbon::Plugin';

use File::Slurp;

sub put {
	my ( $self, $config ) = @_;

	write_file( $config->{destination}, $config->{content} );
	chmod( 0666, $config->{destination} );
}

sub get {
	my ( $self, $config ) = @_;

	return read_file( $config->{destination} );
}

__PACKAGE__->meta()->make_immutable();

1;
