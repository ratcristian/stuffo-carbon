package Stuffo::Carbon::Controllers::Default;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::Carbon::PluginFactory;
use Stuffo::Carbon::Helpers::Configuration qw( get_model_from_name );

sub put {
	my $self = shift();

	my $model = get_model_from_name( $self->param( 'config' ) );
	return $self->render_not_found()
		unless( $model );

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

	my $model = get_model_from_name( $self->param( 'config' ) );
	return $self->render_not_found()
		unless( $model );

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

	my $model = get_model_from_name( $self->param( 'config' ) );
	return $self->render_not_found()
		unless( $model );

	return $self->render( json => $model->pack() );
}

1;