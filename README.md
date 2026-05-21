English | [简体中文](README.zh-CN.md)

# JVM memory under a cgroup limit

BuildKit caches the Maven wrapper and dependencies under `/root/.m2` after copying the POM, so source edits reuse dependency resolution. Repeated builds are faster, download less, and cost less in CI.


Run `./mvnw -q verify`, then `docker build -t stubline-cgroup-memory:local .`. Run `./scripts/run-memory.sh heap`, `percentage`, and `direct`. Each container has a 256 MiB memory limit. `heap` uses `-Xmx64m`, so a retained heap allocation should throw Java `OutOfMemoryError` and exit nonzero with `OOMKilled=false`. `percentage` uses `-XX:MaxRAMPercentage=60` to show how the heap tracks the container limit, then likewise throws Java `OutOfMemoryError`. `direct` uses `-Xmx64m -XX:MaxDirectMemorySize=1g` and retains direct buffers until the cgroup's kernel limit kills the container; expect exit 137 and `OOMKilled=true` from `docker inspect`. Exact allocation step varies. On call, compare application logs and `docker inspect`, then check heap settings, direct and native memory, the cgroup limit, and recent container restarts before changing limits.

## License

This repository is licensed under the [MIT License](LICENSE).

## About this repository

This repository contains a focused Stubline experiment. The README documents its commands and observed results.

The code and documents in this repository were written with the help of AI tools; every recorded output comes from actually running them.
