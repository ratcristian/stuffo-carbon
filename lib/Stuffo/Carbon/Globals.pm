package Stuffo::Carbon::Globals;

use Moose;

# --- Configuration ---

use Config::JSON;

class_has 'config' => (
	is => 'ro',
	isa => 'Config::JSON',
	default => sub {
		return Config::JSON->new( $ENV{STUFFO_CARBON_CONFIG} );
	}
);

__PACKAGE__->meta()->make_immutable();

1;