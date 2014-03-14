package Stuffo::Carbon::Helpers::Configuration;

use Moose;
use Moose::Exporter;

use Stuffo::Carbon::Globals;
use Stuffo::Carbon::ModelFactory;

Moose::Exporter->setup_import_methods(
	as_is => [ qw( get_model_from_name ) ]
);

sub get_model_from_name {
	my $name = shift();

	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $name ) );

	return ( $config ) ?
		Stuffo::Carbon::ModelFactory->create( 'configuration', $config ) :
		undef;
}

1;