#!/bin/sh

set -e
set -u
set -x
set -o pipefail

DEST_DIR=${WWW_DIR:-"/var/www/html"}

if [ -z "$(ls -A $DEST_DIR/assets/stories/)" ]; then
    cp -rt $DEST_DIR/assets/ /stories
    chmod -R ugo+w $DEST_DIR/assets/stories/
fi