package Stuffo::Carbon::Controllers::Default;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::Carbon::Globals;
use Stuffo::Carbon::ModelFactory;
use Stuffo::Carbon::PluginFactory;

sub index {
	my $self = shift();

	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $self->param( 'config' ) ) );

	return $self->render_not_found()
		unless( $config );

	my $config_model = Stuffo::Carbon::ModelFactory->create( 'configuration', $config );

	my $plugin = Stuffo::Carbon::PluginFactory->create(
		$config_model->plugin(),
		$config_model->plugin_args(),
	);

	$plugin->copy(
		{
			content => $self->req()->body(),
			destination => $config_model->destination(),
		}
	);

	return $self->render( json => {} );
}

1;