package Stuffo::Carbon::Controllers::Default;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::Carbon::Globals;
use Stuffo::Carbon::ModelFactory;
use Stuffo::Carbon::PluginFactory;

sub put {
	my $self = shift();

	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $self->param( 'config' ) ) );

	return $self->render_not_found()
		unless( $config );

	my $model = Stuffo::Carbon::ModelFactory->create( 'configuration', $config );
	my $plugin = Stuffo::Carbon::PluginFactory->create( $model->plugin(), $model->plugin_args() );

	$plugin->put(
		{
			content => $self->req()->body(),
			destination => $model->destination(),
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

	my $model = Stuffo::Carbon::ModelFactory->create( 'configuration', $config );

	return $self->render( json => $model->pack() );
}

1;