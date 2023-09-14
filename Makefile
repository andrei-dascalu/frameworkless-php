CLI_CONTAINER="php-cli"
APP_CONTAINER="php-app"
PACKAGE=

## Install composer dependencies
composer/install:
	docker-compose -f docker-compose.yaml run ${CLI_CONTAINER} "composer install -o --no-scripts"

## Add new composer dependency
composer/add:
	docker-compose -f docker-compose.yaml run ${CLI_CONTAINER} "composer require ${PACKAGE}"

composer/add-dev:
	docker-compose -f docker-compose.yaml run ${CLI_CONTAINER} "composer require --dev ${PACKAGE}"

composer/update:
	docker-compose -f docker-compose.yaml run ${CLI_CONTAINER} "composer update -W"

## Create local SSL certificates for frameworkless.dev
ssl:
	echo "Changing domain needs changes in traefik.yaml config"
	cd ./.setup/traefik/certificates && mkcert -install "*.frameworkless.dev" "frameworkless.dev"
	echo "You can add frameworkless.dev as well as any subdomains to your hosts file pointing to 127.0.0.1 (eg: traefik.frameworkless.dev)"

## Check domain certs
ssl/check:
ifneq (,$(wildcard ./.setup/traefik/certificates/_wildcard.frameworkless.dev+1-key.pem))
	echo "TLS certificates ok"
	echo "You can add frameworkless.dev as well as any subdomains to your hosts file pointing to 127.0.0.1 (eg: traefik.frameworkless.dev)"
else
	make ssl/certificates
endif


logs:
	docker-compose logs -f ${APP_CONTAINER}

ssh:
	docker-compose exec ${APP_CONTAINER} sh
