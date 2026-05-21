#!/bin/sh
set -u
case "${1:-}" in
  heap) java_options='-Xmx64m'; mode=heap ;;
  percentage) java_options='-XX:MaxRAMPercentage=60'; mode=heap ;;
  direct) java_options='-Xmx64m -XX:MaxDirectMemorySize=1g'; mode=direct ;;
  *) echo 'use heap, percentage, or direct' >&2; exit 2 ;;
esac
name=stubline-memory-${1}
docker rm -f "$name" >/dev/null 2>&1 || true
docker run --name "$name" --memory 256m --cpus 1 stubline-cgroup-memory:local $java_options -cp app.jar com.elsworne.stubline.spike.cgroup.MemoryMain "$mode"
status=$?
printf 'exitCode=%s\n' "$status"
docker inspect -f 'OOMKilled={{.State.OOMKilled}} ExitCode={{.State.ExitCode}}' "$name"
exit 0
