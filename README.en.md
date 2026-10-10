# Daxuan R writing

> Turn real data tasks into runnable, auditable R code without silently multiplying rows.

This Agent Skill routes the writing, repair, organization, and execution of R code for clinical, GWAS, bulk omics, single-cell, spatial, multi-omics, and other biomedical data work. It inspects actual files, columns, object classes, and matrix orientation; keeps raw inputs read-only; and reports what was really checked.

## Routing

“Integration” means that `daxuan-r-writing` can detect, install when clearly needed, and call a companion skill. It does not vendor that repository's code, rules, or dependencies. The routing table, data-domain checks, and exact install templates are in [references/skill-routing.md](references/skill-routing.md). Common routes include `data-cleaning`, `data-wrangling`, `tidyverse-patterns`, `rlang-patterns`, and `ggplot2-pub`; domain definitions and verification remain project-specific.

When a user provides a script, function, notebook, or analysis template, the skill first extracts its inputs, outputs, package versions, object classes, matrix orientation, parameters, and checks. It then adapts the smallest runnable part to the current project instead of copying unverified thresholds or biological assumptions.

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
