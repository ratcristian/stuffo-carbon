# stuffo-carbon

Distribute files in multiple backends

## Installation

### Requirements

### System

```
perl Build.PL
./Build installdeps
./Build
./Build test && ./Build install
```

### Apache

```
<VirtualHost *:80>
	SetEnv STUFFO_CARBON_CONFIG [/path/to/configuration.json]

	<Location /carbon>
		SetHandler perl-script
		PerlResponseHandler Plack::Handler::Apache2
		PerlSetVar psgi_app [/path/to/stuffo-carbon.pl]
	</Location>
</VirtualHost>
````

## Configuration

```
{
	"configurations" : {
		"seed" : {
			"plugin" : "local",
			"plugin_args" : {},
			"destination" : "/tmp/seed.txt"
		}
	}
}
```