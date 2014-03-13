package Stuffo::Carbon::Plugins::Local;

use Moose;

extends 'Stuffo::Carbon::Plugin';

use File::Slurp;

sub put {
	my ( $self, $config ) = @_;

	write_file( $config->{destination}, $config->{content} );
}

sub get {
	my $self = shift();

	return read_file( $config->{destination} )
}


__PACKAGE__->meta()->make_immutable();

1;