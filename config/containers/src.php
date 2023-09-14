<?php

return [
    'App\*\*' => DI\autowire('App\*\*'),
    'db.host' => function () {
        return getenv("DB_HOST");
    },
];
