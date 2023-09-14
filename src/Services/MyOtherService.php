<?php

declare(strict_types=1);

namespace App\Services;

use DI\Attribute\Inject;

class MyOtherService
{
    #[Inject("db.host")]
    private string $test;

    public function __construct(private MyTestService $service)
    {
    }

    public function getMyName()
    {
        return $this->service->decorate(self::class);
    }
}
