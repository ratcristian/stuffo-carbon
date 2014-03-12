package Stuffo::Carbon::ModelFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

implementation_class_via sub {
	return sprintf( 'Stuffo::Carbon::Models::%s', camelize( shift() ) );
};

1;