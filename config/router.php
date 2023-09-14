<?php

declare(strict_types=1);

use App\Controllers\MyController;
use League\Route\RouteGroup;
use League\Route\Router;
use League\Route\Strategy\ApplicationStrategy;

/** @var \DI\Container $container */

$request = Laminas\Diactoros\ServerRequestFactory::fromGlobals(
    $_SERVER,
    $_GET,
    $_POST,
    $_COOKIE,
    $_FILES
);

$router = new Router();

$strategy = new ApplicationStrategy();
$strategy->setContainer($container);
$router->setStrategy($strategy);

// map a route
$router->map('GET', '/handle', [MyController::class, 'handle']);

$router->group('/api', function (RouteGroup $route) {
    $route->map('GET', '/route1', [MyController::class, 'route1']);
    $route->map('GET', '/route2', [MyController::class, 'route2']);
});

return $router;
