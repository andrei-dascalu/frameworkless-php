<?php

declare(strict_types=1);

use Nyholm\Psr7\Factory\Psr17Factory;
use Nyholm\Psr7\Response;
use Psr\Http\Message\ServerRequestInterface;
use Spiral\RoadRunner\Worker;
use Spiral\RoadRunner\Http\PSR7Worker;

require_once(__DIR__ . '/../config/bootstrap.php');

$worker = Worker::create();
$psrFactory = new Psr17Factory();

$psr7 = new PSR7Worker($worker, $psrFactory, $psrFactory, $psrFactory);

while (true) {
    try {
        $request = $psr7->waitRequest();
        $response = null;

        if (!($request instanceof ServerRequestInterface)) {
            break;
        }

        $response = $router->dispatch($request);
    } catch (Throwable $ex) {
        $response = new Response(500, [], $ex->getMessage());
    }

    $psr7->respond($response);
}
