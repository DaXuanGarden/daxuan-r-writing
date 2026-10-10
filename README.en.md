# Daxuan R writing

> Turn real data tasks into runnable, auditable R code without silently multiplying rows.

This Agent Skill helps write, repair, organize, and run R code for real data processing and analysis, with particular care for MIMIC/eICU-style clinical tables. It inspects the actual files and columns, states row grain and join keys, keeps raw inputs read-only, and reports what was really checked.

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
