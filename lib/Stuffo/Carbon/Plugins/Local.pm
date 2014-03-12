package Stuffo::Carbon::Plugins::Local;

use Moose;

extends 'Stuffo::Carbon::Plugin';

sub copy {
	my ( $self, $config ) = @_;
}

__PACKAGE__->meta()->make_immutable();

1;