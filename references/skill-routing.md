# R Skill 路由与安装清单

这份清单描述 `daxuan-r-writing` 可以调用的外部 skill。这里的“集成”是路由、按需安装和调用，不是复制外部 skill 的文本、代码或依赖。

## 路由表

| Skill | 适用信号 | 安装来源 | 当前项目中的典型用途 |
|---|---|---|---|
| `data-cleaning` | 缺失、重复、异常、编码、类型、连接审计、清洗日志 | `zhjx19/data-cleaning`，根目录 | GWAS/MR/ANNOVAR 输入质量和 SNP join 前审计 |
| `data-wrangling` | 宽长转换、分组、批量化、累计、滑窗、复杂表格 | `zhjx19/data-wrangling`，根目录 | LDSC、MR、MTAG/CPASSOC 结果整理 |
| `tidy-r` | 现代 tidyverse API、旧代码迁移、风格 | `statzhero/tidy-r-skill`，根目录 | 迁移 `%>%`、`merge()`、旧 scoped verbs 和连接写法 |
| `tidyverse-patterns` | R 4.3+ 的 pipe、join、grouping、purrr、stringr | `ab604/claude-code-r-skills`，`.claude/skills/tidyverse-patterns` | 当前项目的通用 tidyverse 重构 |
| `rlang-patterns` | 动态列名、`{{ }}`、`.data`/`.env`、注入 | `ab604/claude-code-r-skills`，`.claude/skills/rlang-patterns` | 按 trait、文件或参数批量生成函数 |
| `ggplot2-pub` | ggplot2、论文 figure、标签、配色、中文导出、多面板 | `zhjx19/ggplot2-pub`，根目录 | LDSC/MR/富集/热图/森林图统一出图 |
| `r-performance` | profiling、benchmark、大文件和重复计算 | `ab604/claude-code-r-skills`，`.claude/skills/r-performance` | 批量 GWAS 文件、重复 join 和敏感性分析 |
| `r-style-guide` | 命名、函数结构、格式、可读性 | `ab604/claude-code-r-skills`，`.claude/skills/r-style-guide` | 统一历史脚本风格 |
| `tdd-workflow` | 新函数、重构、回归测试、testthat | `ab604/claude-code-r-skills`，`.claude/skills/tdd-workflow` | 结果整理函数和输入检查的回归测试 |
| `r-package-development` | R 包、依赖、文档、API | `ab604/claude-code-r-skills`，`.claude/skills/r-package-development` | 将重复的 GWAS 整理逻辑封装为内部包 |
| `r-oop` | S3/S4/S7/vctrs 对象设计 | `ab604/claude-code-r-skills`，`.claude/skills/r-oop` | 仅在构建统一结果对象时调用 |
| `r-bayes` | brms、DAG、边际效应、贝叶斯模型 | `ab604/claude-code-r-skills`，`.claude/skills/r-bayes` | 只有任务明确涉及贝叶斯模型时调用 |

## 运行时查找

优先检查当前 Agent 的用户级 skill 目录和项目级 `.agents/skills`/`.claude/skills`；Codex 通常使用 `~/.codex/skills/<name>/SKILL.md`。不要仅因为仓库存在就声称 skill 已安装，必须看到目标 `SKILL.md`。

## 精确安装模板

公开仓库的根目录 skill：

```bash
python /home/daxuan/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo zhjx19/data-cleaning --path . --ref master --name data-cleaning
```

多 skill 仓库的单个 skill：

```bash
python /home/daxuan/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo ab604/claude-code-r-skills \
  --path .claude/skills/tidyverse-patterns --ref main
```

安装后下一步应明确写出：已安装的 skill、为什么需要它、实际调用范围和剩余未验证项。安装失败时回退到本 skill，不伪造外部调用结果。

## 组合示例

- `data-cleaning → data-wrangling → daxuan-r-writing`：先审计输入，再整理结构，最后写入项目结果。
- `data-wrangling → tidyverse-patterns → daxuan-r-writing`：重构 LDSC/MR/MTAG 结果整理脚本并保留行数和阈值检查。
- `data-cleaning → data-wrangling → ggplot2-pub`：先验证图形输入，再整理绘图数据，最后导出出版级图形。
- `r-performance → daxuan-r-writing`：先定位瓶颈，再只改动已证明影响运行时间的部分。

外部 skill 不会替代项目领域规则：MAF/HWE/INFO、等位基因方向、MR 方法、时间窗和显著性阈值必须由当前项目定义。
