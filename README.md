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

### Local

```
{
	"configurations" : {
		"lorem" : {
			"plugin" : "local",
			"plugin_args" : {},
			"destination" : "/tmp/lorem.txt"
		}
	}
}
```

### SCP

Key configuration

```
sudo su -
mkdir -p /var/www/.ssh
chown -R www-data:www-data /var/www/.ssh

su - www-data
ssh-keygen -t rsa
ssh-copy-id -i /var/www/.ssh/id_rsa.pub user@host
```

```
{
	"configurations" : {
		"lorem" : {
			"plugin" : "scp",
			"plugin_args" : {
				"host" : "localhost",
				"user" : "developer"
			},
			"destination" : "/tmp/lorem.txt"
		},
	}
}
```

### FTP

```
{
	"configurations" : {
		"lorem" : {
			"plugin" : "ftp",
			"plugin_args" : {
				"host" : "localhost",
				"port" : 21,
				"user" : "user",
				"password" : "password",
			},
			"destination" : "/tmp/lorem.txt"
		}
	}
}
```

### Hadoop