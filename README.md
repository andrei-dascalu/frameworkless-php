# Frameworkless PHP Example #

This repository provides an example on how to setup  a local development environment for PHP with the following features:

* TLS enabled with local custom certificates
* A load balancer working on ports 443 and 80
* High performance PHP execution platform
* Custom "framework" setup by bootstrapping various PHP packages together

On top of this you can add additional packages like:

* Monolog, for logging
* Doctrine ORM
* JMS serializer - coupled with the router it helps to create a JSON RESTful API
* others ...

The caveat here is that instead of cryptic YAML configs, you will need to write additional code in the containers folder in order to configure said packages so that the autowiring DI container knows about them.

## Prerequisites ##

### MacOS ###

* `homebrew`
* Run: `brew install git mkcert nss && brew install --cask docker`

### Windows ###

* Install Chocolatey (Windows Package Manager): `https://chocolatey.org/install`
* Run (in an Administrator terminal): `choco install make git docker-desktop docker-compose mkcert`

## Project Setup ##

Copy the `.env.dist` file as `.env` and change to taste

The Makefile contains a number of commands:

* `make ssl` will setup TLS certificates. Under Mac, having the `nss` package will ensure that the certificates are recognised across the board. Under Windows, Firefox may need help with manual setup.
* `make start` will start the entire stack
* `make composer/install` will ensure installation of composer packages
