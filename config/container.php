<?php

$builder = new DI\ContainerBuilder();

if (getenv('APP_ENV') === 'prod') {
    $builder->enableCompilation('/tmp/container');
}

//add other files as needed
$containers = [
    'src',
];

foreach ($containers as $container) {
    $builder->addDefinitions(sprintf('%s/containers/%s.php', __DIR__, $container));
}

return $builder->build();
