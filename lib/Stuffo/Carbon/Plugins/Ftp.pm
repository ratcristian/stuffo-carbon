package Stuffo::Carbon::Plugins::Ftp;

use Moose;

extends 'Stuffo::Carbon::Plugin';

use Net::FTP;

use File::Temp qw( tempfile );
use File::Slurp;

has 'host' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has 'port' => (
	is => 'ro',
	isa => 'Int',
	default => 21,
);

has 'user' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has 'password' => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

has '_ftp' => (
	is => 'ro',
	isa => 'Net::FTP',
	lazy => 1,
	default => sub {
		my $self = shift();

		my $ftp = Net::FTP->new(
			Host => $self->host(),
			Port => $self->port(),
			Passive => 1,
		);

		$ftp->login( $self->user(), $self->password() );

		return $ftp;
	}
);

sub put {
	my ( $self, $config ) = @_;

	my ( $fh, $filename ) = tempfile();
	write_file( $filename, $config->{content} );

	$self->_ftp()->put( $filename, $config->{destination} );
}

sub get {
	my $self = shift();
}


__PACKAGE__->meta()->make_immutable();

1;