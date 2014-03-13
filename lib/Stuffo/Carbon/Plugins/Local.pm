package Stuffo::Carbon::Plugins::Local;

use Moose;

extends 'Stuffo::Carbon::Plugin';

use File::Slurp;

sub copy {
	my ( $self, $config ) = @_;

	write_file( $config->{destination}, $config->{content} );
}

__PACKAGE__->meta()->make_immutable();

1;