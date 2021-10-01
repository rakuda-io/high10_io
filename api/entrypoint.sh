#!/bin/bash
set -e
rm -f /high10_io/tmp/pids/server.pid #アプリディレクトリを指定
exec "$@"