#!/bin/bash
set -o nounset

LOCK_FILE="/tmp/$1"
LOCK_TIMEOUT_SECONDS=${2:-1800}
SECONDS=0

# lock 用のディレクトリが作成できるか、タイムアウトを迎えるまでループする
# mkdir は atomic(同時に実行されても片方しか成功しない)なのでこれを利用してロックを取得する
# see: http://mywiki.wooledge.org/BashFAQ/045
until mkdir $LOCK_FILE 2> /dev/null
do
    [[ $SECONDS -gt $LOCK_TIMEOUT_SECONDS ]] \
        && echo "timeout: $LOCK_FILE" \
        && exit 1

    echo "waiting: $LOCK_FILE"
    sleep 20
done

echo "created: Lockfile($LOCK_FILE)"
exit 0
