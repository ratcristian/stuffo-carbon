package Stuffo::Carbon::Controllers::Default;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::Carbon::PluginFactory;
use Stuffo::Carbon::Helpers::Configuration qw( get_model_from_name );

sub put {
	my $self = shift();

	eval {
		my $config = get_model_from_name( $self->param( 'config' ) );
		return $self->render_not_found()
			unless( $config );

		my $plugin = Stuffo::Carbon::PluginFactory->create(
			$config->plugin(),
			$config->plugin_args(),
		);

		# File size check
		my $content = $self->req()->body();
		die( 'Maximum file size exceeded' )
			if( length( $content ) > $config->max_size() );

		$plugin->put(
			{
				content => $content,
				destination => $config->destination(),
			}
		);

		return $self->render( json => {} );
	};

	if( my $error = $@ ){
		return $self->render(
			status => 500,
			json => {
				message => $error,
			}
		);
	}
}

sub get {
	my $self = shift();

	eval {
		my $config = get_model_from_name( $self->param( 'config' ) );
		return $self->render_not_found()
			unless( $config );

		my $plugin = Stuffo::Carbon::PluginFactory->create(
			$config->plugin(),
			$config->plugin_args(),
		);

		my $content = $plugin->get(
			{
				destination => $config->destination()
			}
		);

		# TODO: Extract only the filename from the path using File::Basename

		return $self->render( json =>
			{
				name => $config->destination(),
				content => $content,
			}
		);
	};

	if( my $error = $@ ){
		return $self->render(
			status => 500,
			json => {
				message => $error,
			}
		);
	}
}

sub info {
	my $self = shift();

	my $config = get_model_from_name( $self->param( 'config' ) );
	return $self->render_not_found()
		unless( $config );

	return $self->render( json => $config->pack() );
}

1;