English | [简体中文](FINDINGS.zh-CN.md)

# Findings

## What we observed

The three modes use a 256 MiB container limit. `heap` (`-Xmx64m`) and `percentage` (`-XX:MaxRAMPercentage=60`) end in Java `OutOfMemoryError` with `OOMKilled=false`. The direct-buffer mode raises the JVM direct-memory cap to 1 GiB and is killed at the cgroup limit, with exit 137 and `OOMKilled=true`. The allocation step varies between runs.

## Backend decision

A heap exception and a container kill need different diagnostics. The backend resource decision should use application logs together with `docker inspect`, and account for direct and native memory as well as the heap. See [backend ADR 0006 — Bound container resources](https://github.com/codexary/stubline-backend/blob/main/docs/adr/0006-bound-container-resources.md).
