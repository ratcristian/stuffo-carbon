package Stuffo::Carbon::Plugins::Hadoop;

use Moose;

extends 'Stuffo::Carbon::Plugin';

use Net::Hadoop::WebHDFS;

has 'host' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has 'port' => (
	is => 'ro',
	isa => 'Int',
	default => 50070,
);

has '_hadoop' => (
	is => 'ro',
	isa => 'Net::Hadoop::WebHDFS',
	lazy => 1,
	default => sub {
		my $self = shift();

		return Net::Hadoop::WebHDFS->new(
			host => $self->host(),
			port => $self->port(),
		);
	}
);

sub put {
	my ( $self, $config ) = @_;

	$self->_hadoop()->create( $config->{destination}, $config->{content} );
}

sub get {
	my $self = shift();
}

__PACKAGE__->meta()->make_immutable();

1;