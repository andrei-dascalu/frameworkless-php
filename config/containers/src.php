<?php

return [
    'App\*' => DI\autowire(),
    'db.host' => function () {
        return getenv("DB_HOST");
    },
];
