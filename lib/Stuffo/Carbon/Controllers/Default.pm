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

sub get {
	my $self = shift();

	# TODO: Duplicate code, need to solve this...
	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $self->param( 'config' ) ) );

	return $self->render_not_found()
		unless( $config );

	my $model = Stuffo::Carbon::ModelFactory->create( 'configuration', $config );
	my $plugin = Stuffo::Carbon::PluginFactory->create( $model->plugin(), $model->plugin_args() );

	my $content = $plugin->get(
		{
			destination => $model->destination(),
		}
	);

	# TODO: Extract only the filename from the path using File::Basename

	return $self->render( json => 
		{
			name => $model->destination(),
			content => $content,
		} 
	);
}

sub info {
	my $self = shift();

	# TODO: More duplicate code...
	my $config = Stuffo::Carbon::Globals->config()
		->get( sprintf( 'configurations/%s', $self->param( 'config' ) ) );

	return $self->render_not_found()
		unless( $config );

	my $model = Stuffo::Carbon::ModelFactory->create( 'configuration', $config );

	return $self->render( json => $model->pack() );
}

1;