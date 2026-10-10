# Daxuan R writing

为真实的数据整理与分析任务编写、修复和运行 R 代码。代码以完成工作为先，同时通过简短注释、关键假设和结果核对，让每一步做了什么都清楚可查。

## 适用任务

- 从 MIMIC/eICU 等数据库提取字段、整理时间和连接表。
- 构建分析队列、处理诊断/用药记录、生成基线表或回归结果。
- 排查脚本报错、行数变化、重复主键或输出不符合预期。
- 整理已有 R 代码，使其直接、可运行、方便审核。

## 你可以直接这样说

- “帮我从 MIMIC 提取心衰诊断，整理成每个 ICU stay 一行并保存结果。”
- “修复 eICU 的连接代码，检查为什么行数变多。”
- “用 R 完成这个队列的描述性分析，并说明输出表代表什么。”

## 本地使用

技能目录：`~/.codex/skills/daxuan-r-writing/`。刷新或重启 Codex 后可调用 `$daxuan-r-writing`。

独立脚本按项目约定使用 `rm(list = ls())`、`gc()` 和明确的 `setwd()`；原始数据保持只读，派生结果写入单独目录。脚本骨架见 [references/script-template.md](references/script-template.md)。

## 检查与排错 / Troubleshooting

- 路径或字段不匹配：查看项目实际目录、`names(data)` 和数据库版本，不套用假定字段。
- 合并后行数变化：核对连接键是否唯一，以及一对多记录是否应先汇总。
- 时间顺序异常：确认数据库中的时间起点和含义，再判断是否符合研究定义。
- R 脚本未在当前环境运行：按交付的 `Rscript` 命令运行；不要把未运行的代码说成已验证。

技能包可用以下命令检查：

```bash
python3 ~/.codex/skills/qiaomu-meta-skill/scripts/validate_skill.py ~/.codex/skills/daxuan-r-writing
```

参考来源：qiaomu-meta-skill; auto-inspire-statsvisual-skill; github/awesome-copilot comment-code-generate-a-tutorial。它们分别启发了技能结构与边界评估、任务导向的分析组织，以及只为关键逻辑添加注释的做法。
