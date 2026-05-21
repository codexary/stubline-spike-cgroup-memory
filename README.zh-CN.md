[English](README.md) | 简体中文

# cgroup 限制下的 JVM 内存

BuildKit 先复制 POM，再在 `/root/.m2` 缓存 Maven wrapper 和依赖；源码变更时可复用依赖解析。重复构建更快、下载更少，CI 成本也更低。


运行 `./mvnw -q verify`，再运行 `docker build -t stubline-cgroup-memory:local .`。分别运行 `./scripts/run-memory.sh heap`、`percentage` 和 `direct`。每个容器限制为 256 MiB。`heap` 使用 `-Xmx64m`，保留的堆分配应导致 Java `OutOfMemoryError`，退出码非零且 `OOMKilled=false`。`percentage` 使用 `-XX:MaxRAMPercentage=60`，展示堆如何跟随容器限制，随后同样抛出 Java `OutOfMemoryError`。`direct` 使用 `-Xmx64m -XX:MaxDirectMemorySize=1g` 并保留直接缓冲区，直到 cgroup 的内核限制杀死容器；预期退出码 137，`docker inspect` 显示 `OOMKilled=true`。具体分配步数会变化。值班工程师应对比应用日志和 `docker inspect`，再检查堆设置、直接及 native 内存、cgroup 限制和最近重启记录，然后再调整限制。

## 许可证

本仓库采用 [MIT License](LICENSE)。

## 关于本仓库

本仓库包含一项针对 Stubline 的独立实验。README 说明运行命令与观察结果。

本仓库的代码与文档借助 AI 工具编写；记录的输出都来自实际运行。
