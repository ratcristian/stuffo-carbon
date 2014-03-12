package Stuffo::Carbon::Models::Configuration;

use Moose;

extends 'Stuffo::Carbon::Model';

has 'plugin' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has 'plugin_args' => (
	is => 'ro',
	isa => 'HashRef',
	required => 1,
);

has 'destination' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

# TODO: Add more features here ...

__PACKAGE__->meta()->make_immutable();

1;