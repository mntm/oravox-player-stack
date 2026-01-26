#!/usr/bin/env sh

set -uxo pipefail

php vendor/bin/phinx migrate -c .phinx.php