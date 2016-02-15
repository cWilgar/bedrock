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

Our site is currently hosted on WP-Engine. We will need to deploy only the contents of the *web folder*. Whether to do this with a subtree or a script or something else is TBD. See the this [getting started article](https://wpengine.com/git/) for more info on deploying with git.

## Automatic Updates

When a new version of wordpress is released and passed beta testing, WP-engine will further test and automatically update the version of wordpress on their servers.

An email will be sent to the admin members of wp-engine when this is going to happen - and wordpress should also send an email to your wp-admin user email. **You should update the version of wordpress in this project in advance [using composer] to make sure it doesn't break anything, and apply the fix if it does.

You can also update wordpress early on wp-engine in the user portal.
More info about wpengine's updates is [here](https://wpengine.com/support/wordpress-updates/).