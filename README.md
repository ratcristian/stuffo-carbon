# stuffo-carbon

Distribute files in multiple backends

## Installation

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
	<Location /carbon>
		SetHandler perl-script
		PerlResponseHandler Plack::Handler::Apache2
		PerlSetVar psgi_app [/path/to/stuffo-carbon.pl]
	</Location>
</VirtualHost>
````
