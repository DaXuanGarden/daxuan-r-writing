# 外部 R 助手：来源与使用地图

`daxuan-r-writing` 的特色是把用户材料接到当前项目。下面的 skill 是可以临时借用的助手，不是本仓库的组成部分；我们记录它们的来源，方便按需安装和复现选择。

## 数据域适配

先根据对象选择检查重点，不根据领域名称自动套流程：

| 数据类型 | 先说清楚什么 | 改代码时看什么 |
|---|---|---|
| 临床表和事件记录 | 一行含义、主键、事件时间、表之间的关系 | 键是否重复、连接后行数、编码和时间解释 |
| GWAS 和遗传学结果 | variant/SNP、等位基因、研究和人群字段 | ID、方向、重复变异、阈值和样本量 |
| bulk 转录组/蛋白组/代谢组 | 样本与特征分别放在哪里、样本信息在哪里 | 维度、名称对齐、缺失、批次和元素数量 |
| 单细胞和空间组学 | cell/spot、sample、feature、注释和对象类型 | 稀疏矩阵方向、元数据、对象转换和批次 |
| 多组学或项目自定义数据 | 各模态的对象、共享 ID 和阶段输出 | 模态间连接、版本、中间对象和最终结果 |

参考代码或脚本只能告诉我们一种实现方式。使用它之前，先记下它读什么、写什么、依赖什么、哪些参数影响结果；示例中的过滤值、标签和科学解释需要当前项目重新确认。

## 可调用的助手

| 名称 | 适合的局部问题 | 来源和路径 |
|---|---|---|
| `data-cleaning` | 字段质量、重复记录、类型和连接关系 | `zhjx19/data-cleaning`，`.` |
| `data-wrangling` | 表格重排、分组计算、批量和滑动处理 | `zhjx19/data-wrangling`，`.` |
| `tidy-r` | 旧写法迁移和现代 tidyverse API | `statzhero/tidy-r-skill`，`.` |
| `tidyverse-patterns` | pipe、join、分组、purrr 和 stringr | `ab604/claude-code-r-skills`，`.claude/skills/tidyverse-patterns` |
| `rlang-patterns` | 动态列名、数据遮罩和可编程函数 | `ab604/claude-code-r-skills`，`.claude/skills/rlang-patterns` |
| `ggplot2-pub` | 论文图形、标签、配色和导出 | `zhjx19/ggplot2-pub`，`.` |
| `r-performance` | profiling、benchmark 和大对象 | `ab604/claude-code-r-skills`，`.claude/skills/r-performance` |
| `r-style-guide` | 命名、格式和函数可读性 | `ab604/claude-code-r-skills`，`.claude/skills/r-style-guide` |
| `tdd-workflow` | 新函数和改写后的回归测试 | `ab604/claude-code-r-skills`，`.claude/skills/tdd-workflow` |
| `r-package-development` | R 包结构、依赖和 API | `ab604/claude-code-r-skills`，`.claude/skills/r-package-development` |
| `r-oop` | S3/S4/S7/vctrs 等对象设计 | `ab604/claude-code-r-skills`，`.claude/skills/r-oop` |
| `r-bayes` | brms、DAG、边际效应和贝叶斯模型 | `ab604/claude-code-r-skills`，`.claude/skills/r-bayes` |

## 安装前的查找

先在项目级 `.agents/skills`、`.claude/skills` 和用户级目录中查找目标 `SKILL.md`。Codex 常用位置是 `~/.codex/skills/<name>/SKILL.md`；只有文件确实存在，才能说它已经安装。

## 安装模板

公开仓库根目录的助手：

```bash
python /home/daxuan/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo zhjx19/data-cleaning --path . --ref master --name data-cleaning
```

多助手仓库中的单个目录：

```bash
python /home/daxuan/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo ab604/claude-code-r-skills \
  --path .claude/skills/tidyverse-patterns --ref main
```

安装后要告诉用户四件事：为什么需要它、实际用了哪一部分、产生了什么结果、还有什么没有验证。网络或安装失败时，继续用本 skill 的代码方式完成能完成的部分，并如实说明原因。

## 常见组合

- 临床表：`data-cleaning` + `data-wrangling`，再由 `daxuan-r-writing` 写入项目脚本。
- GWAS/组学结果：`data-cleaning` + `data-wrangling`，需要论文图时再加 `ggplot2-pub`。
- 单细胞/空间对象：`data-cleaning` + `data-wrangling`，同时尊重项目已有的 Seurat 或 Bioconductor 接口。
- 参考函数改写：`tidyverse-patterns` + `rlang-patterns`，由 `daxuan-r-writing` 处理项目路径和结果检查。
- 运行变慢：先用 `r-performance` 找到证据，再决定是否修改代码。

这些助手不会替项目决定 MAF/HWE/INFO、等位基因方向、MR 方法、细胞过滤、批次处理、时间窗或显著性阈值。
