package Stuffo::Carbon::Plugins::Scp;

use Moose;

extends 'Stuffo::Carbon::Plugin';

use Net::SCP;

use File::Temp qw( tempfile );
use File::Slurp;

has 'host' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has 'user' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has '_scp' => (
	is => 'ro',
	isa => 'Net::SCP',
	lazy => 1,
	default => sub {
		my $self = shift();

		return Net::SCP->new(
			{
				host => $self->host(),
				user => $self->user(),
			}
		);
	}
);

sub put {
	my ( $self, $config ) = @_;

	# TODO: In the future I need to solve the append feature
	# by retrieving the file from the server append the content locally
	# and upload it back to the remote site. 

	my ( $fh, $filename ) = tempfile();
	write_file( $filename, $config->{content} );
	chmod( 0666, $filename );

	$self->_scp()->put( $filename, $config->{destination} )
		or die( $self->_scp()->{errstr} );
}

sub get {
	my ( $self, $config ) = @_;

	my ( $fh, $filename ) = tempfile();
	$self->_scp()->get( $config->{destination}, $filename );

	my $content = read_file( $filename );
	unlink( $filename );

	return $content;
}

__PACKAGE__->meta()->make_immutable();

1;
