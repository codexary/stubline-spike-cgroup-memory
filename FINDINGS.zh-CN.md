[English](FINDINGS.md) | 简体中文

# 实验结论

## 观察

三个模式都把容器内存限制为 256 MiB。`heap`（`-Xmx64m`）和 `percentage`（`-XX:MaxRAMPercentage=60`）最终抛出 Java `OutOfMemoryError`，`OOMKilled=false`。直接缓冲区模式把 JVM 的直接内存上限设为 1 GiB，进程达到 cgroup 限额后被内核终止，退出码为 137，`OOMKilled=true`。每次运行停在哪一步并不固定。

## 对后端的影响

排查堆溢出与容器被杀，所需证据不同。后端的资源配置应结合应用日志与 `docker inspect`，同时考虑堆、直接内存和其他原生内存。参见[后端 ADR 0006：Bound container resources](https://github.com/codexary/stubline-backend/blob/main/docs/adr/0006-bound-container-resources.md)。
