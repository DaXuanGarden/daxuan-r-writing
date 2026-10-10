<sub>中文 · <a href="README.en.md">English</a></sub>

<div align="center">

# Daxuan R writing

> *「先把数据和连接关系看清，再让 R 代码替你跑完。」*

[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-daxuan--r--writing-blueviolet)](SKILL.md)
[![skills.sh](https://skills.sh/b/DaXuanGarden/daxuan-r-writing)](https://skills.sh/DaXuanGarden/daxuan-r-writing)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**把真实数据任务变成可运行、可核对、不会悄悄放大行数的 R 交付物，并在需要时路由到合适的 R skill。**

[看效果](#效果示例) · [安装](#快速开始) · [Skill 路由](#skill-路由) · [触发方式](#触发方式) · [安全边界](#安全边界) · [验证](#verification)

</div>

---

为真实的数据整理与分析任务编写、修复和运行 R 代码。支持临床、GWAS、bulk 组学、单细胞、空间组学、多组学以及用户提供的其他 R 参考代码；代码以完成工作为先，同时通过简短注释、关键假设和结果核对，让每一步做了什么都清楚可查。

## 适用任务

- 从 MIMIC/eICU 等数据库、GWAS、转录组/蛋白组/代谢组、单细胞或空间组学对象中提取字段、整理元数据和结果。
- 构建分析队列、处理诊断/用药记录、生成基线表或回归结果。
- 读取和改写用户提供的 R 脚本、函数、notebook 或分析模板，并核对输入输出、包版本和对象结构。
- 排查脚本报错、行数变化、重复主键或输出不符合预期。
- 整理已有 R 代码，使其直接、可运行、方便审核。

## 效果示例

仓库附带一个不含临床数据的合成示例，用来回放“一行一个 stay、明细先汇总再并回”的检查：

```bash
Rscript examples/join-check/run_example.R
```

示例会读取 `stays.csv` 和 `diagnoses.csv`，输出 `output/cohort_flags.csv`，并检查输出仍是一行一个 `stay_id`：

```text
stay_id,subject_id,diagnosis_count,heart_failure
1001,501,2,1
1002,502,1,0
1003,503,0,0
```

这只是可复现的结构演示，不是 MIMIC/eICU 的研究定义，也不包含真实患者数据。

## 快速开始

```bash
npx skills add DaXuanGarden/daxuan-r-writing
```

安装后直接对 Agent 说：

```text
用 daxuan-r-writing 检查这个 R 合并流程：先确认每张表的一行代表什么和连接键，再修复重复 stay，并运行针对性的行数核对。
```

## Skill 路由

本项目的“集成”指路由、按需安装和调用外部 skill，不把外部仓库的功能、代码、规则或依赖复制进本 skill。完整清单和精确安装模板见 [references/skill-routing.md](references/skill-routing.md)。运行时只有在对应目录存在目标 `SKILL.md` 时，才会报告该 skill 已安装。

常用路由包括：

- `data-cleaning`：输入审计、缺失/重复/编码检查和连接前质量记录。
- `data-wrangling`：宽长转换、分组、批量化、累计和滑窗整理。
- `tidy-r`、`tidyverse-patterns`、`rlang-patterns`：现代 tidyverse、动态列名和 tidy evaluation。
- `ggplot2-pub`：出版级 ggplot2、中文导出、标签、配色和多面板图形。
- `r-performance`、`r-style-guide`、`tdd-workflow`、`r-package-development`、`r-oop`、`r-bayes`：只在性能、风格、测试、包、对象或贝叶斯模型任务明确需要时调用。

对当前项目，一个典型组合是：先按数据域确认对象和 ID，再用 `data-cleaning` 审计输入，用 `data-wrangling` 整理关系表、表达矩阵或单细胞元数据，最后用 `ggplot2-pub` 生成并验收论文图；原有阈值、方法、对象接口和输出格式仍以项目定义为准。

用户给出参考代码时，skill 会先提取输入输出、包版本、矩阵方向、对象类、关键参数和检查逻辑，再改写成当前项目可运行的最小版本。参考代码中的阈值、细胞类型、批次定义、临床编码或生物学解释不会自动继承。

## 你可以直接这样说

- “帮我从 MIMIC 提取心衰诊断，整理成每个 ICU stay 一行并保存结果。”
- “修复 eICU 的连接代码，检查为什么行数变多。”
- “用 R 完成这个队列的描述性分析，并说明输出表代表什么。”
- “审计 GWAS 结果的缺失、重复和 SNP 连接，再整理成可画图的数据。”
- “按出版要求修改这张 ggplot2 图，检查中文字体、标签和导出尺寸。”
- “参考这段 Seurat 代码，按当前样本元数据改写单细胞质控和降维流程，并检查细胞 ID 是否对齐。”
- “根据这个蛋白组分析脚本，保留输入输出和检查逻辑，改成当前项目可运行的 R 脚本。”

## 本地使用

技能目录：`~/.codex/skills/daxuan-r-writing/`。刷新或重启 Agent runtime 后可调用 `$daxuan-r-writing`。

独立脚本按项目约定使用 `rm(list = ls())`、`gc()` 和明确的 `setwd()`；原始数据保持只读，派生结果写入单独目录。脚本骨架见 [references/script-template.md](references/script-template.md)。

## 检查与排错 / Troubleshooting

- 路径或字段不匹配：查看项目实际目录、`names(data)` 和数据库版本，不套用假定字段。
- 合并后行数变化：核对连接键是否唯一，以及一对多记录是否应先汇总。
- 时间顺序异常：确认数据库中的时间起点和含义，再判断是否符合研究定义。
- R 脚本未在当前环境运行：按交付的 `Rscript` 命令运行；不要把未运行的代码说成已验证。

技能包可用以下命令检查：

```bash
./scripts/check_skill.sh
```

检查脚本会校验 JSON、必需文件和合成 R 示例；它不读取或上传你的临床数据。

需要更严格的本地包检查时，也可以运行 `validate_skill.py`；它与本仓库的 smoke test 互补。

## 触发方式

- “帮我写 R 代码，从 MIMIC 提取心衰诊断并整理成每个 ICU stay 一行。”
- “修复 eICU 合并流程，检查为什么行数变多。”
- “把诊断明细按研究定义汇总后并回主表。”
- “用 R 完成这个队列的基线特征和回归分析，并保存结果表。”
- “运行并检查这个 R 数据处理脚本，说明它读取什么、输出什么。”
- “审计 GWAS 结果的缺失、重复和 SNP 连接，并保存清洗报告。”
- “按出版要求修改这张 ggplot2 图，检查中文字体、标签、配色和导出尺寸。”
- “参考这段单细胞 R 代码，适配当前 Seurat 对象并运行必要的维度和元数据检查。”
- “读取这个多组学分析模板，说明哪些参数可以复用，哪些需要当前项目确认。”

只问统计概念或研究设计、且没有 R 产物时不应触发；纯 R 绘图可以触发，但会路由到 `ggplot2-pub`，不会强行执行队列分析。

## 安全边界

- 不修改、移动或重命名原始数据，不把临床数据上传到远程服务。
- 不把候选 ICD 前缀、药物名称或研究定义说成已经验证的标准定义。
- 不把未运行的代码说成已验证；缺少会改变研究对象、暴露/结局时间或连接结果的信息时会停下来询问。
- 只运行当前任务涉及的脚本和检查，不顺手启动无关流程。
- 不声称外部 skill 已安装、已调用或已复制，除非实际检查到目标 `SKILL.md` 并说明调用范围；安装失败时明确回退到本 skill 的流程。
- 不盲目执行用户提供的参考代码；先检查依赖、路径、对象和参数，再在当前环境中运行最小相关部分。

## 文件结构

```text
SKILL.md                         Agent 工作流、边界与检查点
agents/interface.yaml            跨 runtime 的调用接口和权限边界
references/script-template.md    独立 R 脚本骨架
references/skill-routing.md      外部 R skill 路由、来源和安装模板
examples/join-check/             不含临床数据的可复现合成回放
scripts/check_skill.sh           本地结构、JSON 和示例检查
evals/trigger_cases.json         正向、负向和近邻触发样例
LUBAN_REPORT.md                  本轮审计、评分和回炉清单
```

## Verification

在仓库根目录运行：

```bash
./scripts/check_skill.sh
```

合格表现：JSON 校验和路由清单检查通过，示例脚本退出码为 0，输出行数等于输入 stay 数，且 `stay_id` 不重复。

Upstream inspiration: `qiaomu-meta-skill; auto-inspire-statsvisual-skill; github/awesome-copilot`. Details are recorded in the [acknowledgements](#致谢); local references are named there without implying a public upstream repository.

## 致谢

方法论参考了本地的 `qiaomu-meta-skill`、`auto-inspire-statsvisual-skill`，以及 [GitHub Awesome Copilot](https://github.com/github/awesome-copilot) 的注释示例。这些来源启发了技能结构、任务导向的分析组织和关键逻辑注释边界。

## License

[MIT](LICENSE)
