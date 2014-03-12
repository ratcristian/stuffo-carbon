package Stuffo::Carbon::Plugin;

use Moose;

use MooseX::AbstractMethod;

abstract 'copy';

__PACKAGE__->meta()->make_immutable();

1;