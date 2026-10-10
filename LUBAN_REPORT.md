# daxuan-r-writing Skill 打磨报告

审查对象：`daxuan-r-writing` v0.2.0 基线 → v0.3.0 公共候选

审查日期：2026-10-10（同行数据为当天 API 快照）

本轮边界：只刨“公开发布与可验证性”。未上传任何临床数据，也没有把 MIMIC/eICU 的候选定义包装成标准定义。

## 1. 验料结果（Skill 前提挑战）

挑战1 - 真实问题：**成立**。真实 R 数据任务经常同时需要字段核对、连接粒度、时间语义和可复核输出；临时问答容易漏掉这些约束。

挑战2 - 独特角度：唯一性来自 **R + 临床数据库语义 + 一行粒度/连接关系核对 + 原始数据只读** 的组合；不是通用统计教程。

挑战3 - 安装理由：安装后可重复触发同一套检查点和交付约定，减少每次重述“先看字段、别复制 stay、说明实际验证”的成本。

挑战4 - 公共传播性：钩子是“先把数据和连接关系看清，再让 R 代码替你跑完”；本轮补了合成回放和输出 CSV，但还没有 GIF 级展示。

验料结论：**好料，继续打磨**。

## 2. 访行记录（同类 Skill 横向对标）

| 同类 Skill | 链接 | 类型 | 一句话定位 | 它为什么容易被理解/安装/传播 | 可学的手艺 | 不能照搬的点 |
|---|---|---|---|---|---|---|
| aipoch/medical-research-skills | https://github.com/aipoch/medical-research-skills | 直接 | 医学研究 Agent Skill 大库 | 分类、徽章、GIF、每个 Skill 有脚本和评估报告 | 可见产物 + 评估报告绑定 | 不复制“大而全医学库”叙事 |
| wolf5996/agentic-skills | https://github.com/wolf5996/agentic-skills | 直接 | R、生物信息和科研文档的跨 runtime 技能集 | 明列 Codex/Claude、安装和技能组合 | 平台兼容矩阵、依赖图、定制入口 | 不绑定其个人栈和外部服务 |
| JPeetz/agent-skills data-analysis | https://github.com/JPeetz/agent-skills/blob/main/skills/data/data-analysis/SKILL.md | 直接/间接 | 通用数据分析六阶段流程 | frontmatter、When to Trigger、Near-Miss Negatives 清晰 | 固定阶段、反触发、变更审计 | 保留临床时间语义和 R 约束 |
| KalarisLabs/research-agent-skills | https://www.skills.sh/kalarislabs/research-agent-skills/exploratory-data-analysis | 间接 | 研究 EDA 与安全边界 | 一条安装命令、格式矩阵、审计徽章 | 输入范围→输出→失败闭环 | 不引入 Python 3.11 的依赖负担 |
| Data Analysis 1 | https://clawhub.ai/tigertamvip/skills/data-analysis-1 | 间接 | 从数据到可行动结论的分析流程 | 安装短、先锁 metric contract、列出红旗 | 把研究对象/粒度/时间窗写成合同 | 不照搬业务 KPI 语言 |
| K-Dense scientific-writing | https://tessl.io/registry/skills/github/K-Dense-AI/scientific-agent-skills/scientific-writing | 手艺 | 带证据溯源的科研写作 | Quality/Snyk、可执行审计脚本、证据 ID | claim→evidence 和一致性校验 | 不把稿件工具链塞进 R Skill |
| SkillMD | https://github.com/skillmds/skillmd | 手艺 | 能 lint/scan/publish 的 Skill registry | 一条 npx 命令、质量和安全旗标 | 轻量 lint、能力声明、发布前阻断 | 不复制 registry 产品复杂度 |

## 3. 生态位判断

纵向结论：这个 Skill 从个人临床 R 约定起步，下一阶段应把“连接和时间语义检查”变成陌生 Agent 也能复用的轻量协议。

横向结论：同类项目靠首屏一句话、单命令安装、跨 runtime 元数据、可见输出和可执行验证建立信任。

交叉洞察：应抢的生态位不是“又一个 R 教程”，而是 **临床表格连接风险的 R 交付协议**：先声明粒度和键，再产生脚本、检查结果和限制说明。

一句话新定位：**为 MIMIC/eICU 等临床数据任务生成一行粒度明确、连接关系可核对、结果可复跑的 R 代码。**

## 4. 过尺结果（活体检查 + 质量评分）

### 活体证据

- 文档命令：`Rscript examples/join-check/run_example.R` 已实跑，退出码 0，输出 3 行且 `stay_id` 无重复。
- 仓库检查：`./scripts/check_skill.sh` 已实跑，通过 JSON、R 回放和输出断言。
- 结构尺：Luban checker 从基线的 `6 PASS / 1 FAIL / 6 WARN` 变为 `12 PASS / 0 FAIL / 1 WARN`。
- 本轮没有真实 MIMIC/eICU 数据可公开回放；合成 fixture 只验证连接粒度和失败停点，不证明任何临床定义。
- 剩余警告：没有 GIF/视频；这是传播资产缺口，不影响脚本回放正确性。

### 九维评分

| 维度 | 权重 | 得分 | 主要证据 | 最大短板 | 优先级 |
|---|---:|---:|---|---|---|
| Frontmatter 与触发条件 | 7 | 7 | 描述含任务、触发词和负触发 | 缺平台 tags 字段 | P2 |
| 工作流清晰度 | 12 | 10 | SKILL.md 六步顺序和停点 | 缺输入/输出契约表 | P1 |
| 失败模式编码 | 12 | 8 | 字段、键重复、行数、时间顺序检查 | 没有稳定错误码 | P1 |
| 检查点设计 | 6 | 6 | 必需字段、唯一键、行数、时间检查 | 复杂回归检查仍靠任务定制 | P2 |
| 可执行具体性 | 17 | 14 | 脚本骨架、合成回放、输出断言 | 缺真实数据库示例 | P1 |
| 资源整合度 | 4 | 4 | references、agents、evals、examples | 无自动 CI | P2 |
| 整体架构 | 12 | 10 | SKILL/接口/模板/测试/报告分层 | 插件元数据仍是最小实现 | P2 |
| 实测表现 | 23 | 15 | R 4.3.3 实跑，3 行输出对账 | 未用真实临床数据回放 | P1 |
| 反例与黑名单 | 7 | 7 | 负触发、安全边界、禁止事项 | 可补外部 API/路径越界案例 | P2 |
| **总分** | **100** | **81** | 结构 + 合成活体证据 | **真实数据和 GIF 证据缺失** | **P1** |

## 5. 差距清单

### P0：不补就无法公开/无法信任

- 已补齐：README、LICENSE、安装命令、合成 fixture、检查脚本、插件元数据。
- 尚未补齐：真实公开数据或脱敏回放证据；因此不能宣传为“已验证临床流程”。

### P1：补上后明显提升安装率/传播率

- 为 2 个典型临床任务增加不含数据的输入/输出契约和失败码示例。
- 加一条 GitHub Actions 检查 `scripts/check_skill.sh`，让 JSON 和合成回放每次提交都运行。
- 用真实运行终端录制 GIF，并把录制脚本和产物一起入库。

### P2：锦上添花

- `platforms`、`tags`、版本兼容矩阵。
- 中英文 README 的更多示例。
- 发布后加入 R skill 目录并观察安装/克隆数据。

### 与同行相比，我们最缺的 3 件事

1. 真实运行产物和可视化首屏证明。
2. 稳定的失败码、输入输出契约和边界测试。
3. 公共 CI 与发布后流量/安装数据。

### 与同行相比，我们最有机会打穿的 3 件事

1. 明确处理临床表格的一行粒度和一对多连接风险。
2. 同时覆盖 MIMIC/eICU 语义边界和 R 代码交付。
3. 坚持原始数据只读、证据绑定和不把候选定义说成标准定义。

## 6. 三个打磨方向

### 方案A：细修——把现在的 Skill 做清楚

新定位：临床 R 任务的输入/输出/核对协议。

改动范围：补契约表、失败码、更多 trigger cases 和 CI。

优点：改动小、安装摩擦低、容易跨 runtime。

风险：展示效果仍偏文字和 CSV。

适合条件：优先提高日常调用稳定性。

### 方案B：精雕——做出同行没有的可见产物

新定位：输入表→连接审计→R 脚本→核对报告的临床数据回放 Skill。

改动范围：加入脱敏/公开数据回放、HTML 或 Markdown 审计报告、GIF 和 before/after 行数证据。

优点：最容易证明“为什么值得安装”。

风险：需要维护公开数据版本和回放成本。

适合条件：目标是提高 GitHub 传播和可信度。

### 方案C：开套件——从单 Skill 升级为小型 Skill 套件

新定位：R 临床数据工作流套件（队列、基线、回归、结果审计分包）。

改动范围：拆分多个 SKILL.md、共享 fixtures 和版本矩阵。

优点：覆盖面和可组合性更强。

风险：维护面扩大，容易变成没有验证的大目录。

适合条件：已有多个稳定任务和真实用户反馈后再做。

推荐选择：**先执行方案A，再以方案B作为下一轮目标**。

推荐理由：本轮已经补了最小公共资产；先建立 CI、契约和失败码，再用真实回放做传播证明。方案C 暂不启动。

## 7. 候选改写方案

本轮只刨：公开发布与可验证性。

改动边界：修改 `SKILL.md`、`README.md`、`manifest.json`，新增 `examples/`、`scripts/`、`LICENSE`、`.claude-plugin/marketplace.json` 和本报告；不加入真实临床数据、不调用外部 API。

预期提升：陌生用户能安装、运行合成回放并看到输出；维护者能用一条命令发现 JSON、字段粒度和重复 stay 错误。

验证方式：`./scripts/check_skill.sh`、Luban checker、qiaomu validator，以及 R 4.3.3 实跑。

## 8. README 与 Showcase 升级建议

- 已完成：引语钩子、skills.sh 徽章、`npx skills add`、安装后第一句话、合成输出、触发方式、安全边界、文件结构、验证命令。
- 下一轮：加入真实终端 GIF 和对应录制脚本；GIF 必须由仓库内命令重新生成，不能摆拍。
- 不写未经链接的数据量、星数或“支持所有临床数据库”等大词。

## 9. 执行计划

### 24 小时内必须完成

- [x] 冻结 v0.2.0 基线。
- [x] 补公开发布资产和合成回放。
- [x] 跑结构检查、JSON 检查和 R 回放。
- [ ] 将当前提交推送到 GitHub 新仓库。

### 3 天内完成

- [ ] 增加 GitHub Actions smoke test。
- [ ] 增加 2 个临床任务的无数据契约和失败码样例。
- [ ] 录制可复现终端 GIF。

### 7 天内完成

- [ ] 选择一份可公开使用的数据或脱敏 fixture 做真实回放。
- [ ] 记录安装/克隆数据，按证据更新 README。

### 本轮不做

- 不新增外部 API、危险脚本或真实临床数据。
- 不拆成多个 Skill，不打 tag，不发布 ClawHub/skills.sh 注册表。

## 10. 出师证书

```text
┌─────────────────────────────────────┐
│  出师证书 · 鲁班工坊                │
│                                     │
│  作品：daxuan-r-writing             │
│  过尺：基线估算 63 分 → 当前 81 分    │
│  定位：临床表格连接风险的 R 交付协议 │
│  绝活：一行 stay + 连接核对 + 证据边界│
│  下一步：真实回放、CI 和 GIF         │
│                                     │
│  验收师傅：鲁班                     │
└─────────────────────────────────────┘
```

当前 81 分包含合成活体实测，不等同于真实 MIMIC/eICU 研究验证。

## 11. 回炉清单

- 对标观察：持续关注 [aipoch/medical-research-skills](https://github.com/aipoch/medical-research-skills) 的评估报告、[JPeetz/agent-skills](https://github.com/JPeetz/agent-skills) 的触发边界、[KalarisLabs/research-agent-skills](https://www.skills.sh/kalarislabs/research-agent-skills/exploratory-data-analysis) 的安全审计和 [SkillMD](https://github.com/skillmds/skillmd) 的 lint 能力。
- 迭代纪律：每次修改先跑 `./scripts/check_skill.sh`，每个可发布提交写清“为什么改”，验证通过后再推送；发布前不把合成回放数字写成临床效果。
- 下一轮入口：先补稳定错误码和 GitHub Actions，再做公开数据回放；GIF 缺口保留到录制工具可复现时处理。

## 12. 需要用户确认的问题

1. GitHub 仓库名是否采用 `DaXuanGarden/daxuan-r-writing`？
2. 下一轮优先补 GitHub Actions/失败码（方案A），还是优先做真实公开数据回放和 GIF（方案B）？
3. 是否希望后续把该 Skill 收录到 skills.sh、ClawHub 或 R skill 目录？每个注册表发布动作需要单独授权。

## 13. 附录：参考来源

- https://github.com/aipoch/medical-research-skills
- https://github.com/wolf5996/agentic-skills
- https://github.com/JPeetz/agent-skills/blob/main/skills/data/data-analysis/SKILL.md
- https://www.skills.sh/kalarislabs/research-agent-skills/exploratory-data-analysis
- https://clawhub.ai/tigertamvip/skills/data-analysis-1
- https://tessl.io/registry/skills/github/K-Dense-AI/scientific-agent-skills/scientific-writing
- https://github.com/skillmds/skillmd
- https://github.com/christopherkenny/awesome-rstats-skills
