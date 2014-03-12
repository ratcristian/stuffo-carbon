#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
	module_name => 'Stuffo::Carbon',

	dist_author => 'Tudor Marghidanu',
	dist_abstract => '',

	share_dir => 'share',

	# NOTE: Keep this list ordered!
	requires => {
		'Config::JSON' => undef,
		'Mojolicious' => undef,
		'Moose' => undef,
		'MooseX::AbstractFactory' => undef,
		'MooseX::AbstractMethod' => undef,
		'MooseX::ClassAttribute' => undef,
		'Net::FTP::File' => undef,
		'Net::Hadoop::WebHDFS' => undef,
		'Net::SCP' => undef,
		'Plack' => undef,
		'String::CamelCase' => undef,
	}
);

$build->create_build_script();