#!/bin/bash
set -o pipefail
set -o nounset
set -o errexit

LOCK_FILE="/tmp/$1"
rm -rf "$LOCK_FILE"
echo "deleted: Lockfile($LOCK_FILE)"
