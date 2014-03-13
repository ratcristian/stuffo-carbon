package Stuffo::Carbon::Controllers::Default;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::Carbon::Globals;
use Stuffo::Carbon::ModelFactory;
use Stuffo::Carbon::PluginFactory;

sub copy {
	my $self = shift();

	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $self->param( 'config' ) ) );

	return $self->render_not_found()
		unless( $config );

	my $model = Stuffo::Carbon::ModelFactory->create( 'configuration', $config );
	my $plugin = Stuffo::Carbon::PluginFactory->create( $model->plugin(), $model->plugin_args() );

	$plugin->copy(
		{
			content => $self->req()->body(),
			destination => $config_model->destination(),
		}
	);

	return $self->render( json => {} );
}

sub info {
	my $self = shift();

	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $self->param( 'config' ) ) );

	return $self->render_not_found()
		unless( $config );

	return $self->render( json => $config );
}

1;