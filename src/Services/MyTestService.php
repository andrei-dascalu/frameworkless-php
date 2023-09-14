<?php

declare(strict_types=1);

namespace App\Services;

class MyTestService
{
    public function decorate(string $target)
    {
        return sprintf('Prefix %s suffix', $target);
    }
}
