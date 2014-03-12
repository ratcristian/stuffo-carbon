package Stuffo::Carbon::PluginFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

implementation_class_via sub {
	return sprintf( 'Stuffo::Carbon::Plugins::%s', camelize( shift() ) );
};

1;