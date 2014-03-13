package Stuffo::Carbon::Model;

use Moose;

use MooseX::Storage;

with Storage();

__PACKAGE__->meta()->make_immutable();

1;