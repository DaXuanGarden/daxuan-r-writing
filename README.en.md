# Daxuan R writing

> Turn real data tasks into runnable, auditable R code without silently multiplying rows.

This Agent Skill routes the writing, repair, organization, and execution of R code for real clinical, GWAS, and omics data work. It inspects actual files and columns, states row grain and join keys, keeps raw inputs read-only, and reports what was really checked.

## Routing

“Integration” means that `daxuan-r-writing` can detect, install when clearly needed, and call a companion skill. It does not vendor that repository's code, rules, or dependencies. The routing table and exact install templates are in [references/skill-routing.md](references/skill-routing.md). Common routes include `data-cleaning`, `data-wrangling`, `tidyverse-patterns`, `rlang-patterns`, and `ggplot2-pub`; domain definitions and verification remain project-specific.

## Install

```bash
npx skills add DaXuanGarden/daxuan-r-writing
```

After installation, ask:

```text
Use daxuan-r-writing to inspect this R join: identify each table's row grain and key, prevent duplicated stays, and run focused row-count checks.
```

The repository includes a synthetic, non-clinical join-check example:

```bash
Rscript examples/join-check/run_example.R
```

See the [Chinese README](README.md) for trigger examples, safety boundaries, verification, and file structure.
