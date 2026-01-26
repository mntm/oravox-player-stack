#!/usr/bin/env sh

set -uxo pipefail

echo "Put migration to sleep"
sleep 15s

php vendor/bin/phinx migrate -c .phinx.php