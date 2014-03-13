package Stuffo::Carbon::Plugin;

use Moose;

use MooseX::AbstractMethod;

abstract 'put';

abstract 'get';

__PACKAGE__->meta()->make_immutable();

1;