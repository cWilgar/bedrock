# ROLI BLOG 2

This project is built from the [Bedrock](https://roots.io/bedrock/) biolerplate. Which means we can control all our worpress dependencies with composer. Read [this lovely article](https://roots.io/using-composer-with-wordpress/) if you need to get familiar with managing wordpress this way.

## Requirements

* PHP >= 5.5
* Composer - [Install](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx)

## Installation

1. Clone the git repo

1. Run your db server
`mysql.server start`

1. Create a database called roli_blog_dev
`echo "CREATE DATABASE roli_blog_dev" | mysql -u root`

1. Run `composer install`

1. Copy `.env.example` to `.env` and update environment variables:
	* `DB_NAME` - 'roli_blog_dev'
	* `DB_USER` - 'root'
	* `DB_PASSWORD` - ''
	* `DB_HOST` - 'localhost'
	* `WP_ENV` - 'development'
	* `WP_HOME` - 'http://localhost:3000/'
	* `AUTH_KEY`, `SECURE_AUTH_KEY`, `LOGGED_IN_KEY`, `NONCE_KEY`, `AUTH_SALT`, `SECURE_AUTH_SALT`, `LOGGED_IN_SALT`, `NONCE_SALT` - Generate with [wp-cli-dotenv-command](https://github.com/aaemnnosttv/wp-cli-dotenv-command) or from the [WordPress Salt Generator](https://api.wordpress.org/secret-key/1.1/salt/)

1. Run the server from within the web folder
`cd web`
`php -S localhost:3000`

1. Go to `http://localhost:3000/wp` in your browser and you will go the the wordpress setup screen.

## Deployment

Our site is hosted on WP-Engine. We deploy only the contents of the *web folder* using git. See the this [getting started article](https://wpengine.com/git/) for more info.

1. Add your ssh public key to wp-engine via the [admin web interface](https://my.wpengine.com/installs/roli/git_push).

1. Add the git remotes for staging and production.
	```sh
	cd web
	git remote add production git@git.wpengine.com:production/roliblog.git
	git remote add staging git@git.wpengine.com:staging/roliblog.git
	```

1. Then just push the branch you wish to deploy to the production/staging remote.
wp-engine will then deploy the pushed code to their servers.
	```sh
	git push staging master
	```

1. **At this point you will need to log in to the wordpress admin, go to Settings => Permalinks => Save Changes. Until this is done, any page with a generated url WILL BE BROKEN. So be ready to hit that button as soon as the push has finished.**

If everything looks OK there, and you have the green light, push to the
production remote.

**Once again you will need to log in to the wordpress admin, go to Settings => Permalinks => Save Changes. Until this is done, any page with a generated url WILL BE BROKEN. So be ready to hit that button as soon as the push has finished.**

The CSS is not rebuilt on the server, so it is vital that the latest version
of the compiled CSS is commited.

## Automatic Updates

When a new version of wordpress is released and passed beta testing, WP-engine will further test and automatically update the version of wordpress on their servers.

An email will be sent to the admin members of wp-engine when this is going to happen - and wordpress should also send an email to your wp-admin user email. **You should update the version of wordpress in this project in advance [using composer] to make sure it doesn't break anything, and apply the fix if it does.

You can also update wordpress early on wp-engine in the user portal.
More info about wpengine's updates is [here](https://wpengine.com/support/wordpress-updates/).