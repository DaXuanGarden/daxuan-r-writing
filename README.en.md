# Daxuan R writing

> Turn reference R code into code that belongs in the current project.

`daxuan-r-writing` is an R implementation layer for clinical data, GWAS, bulk omics, single-cell, spatial omics, multi-omics, and other user-provided R workflows. It starts from the files, objects, scripts, and goals in front of it instead of assuming one analysis framework.

## What makes it ours

- It learns from the user's scripts, functions, notebooks, examples, and error messages.
- It protects the meaning of tables, matrices, sparse matrices, and R objects before changing code.
- It keeps reusable code separate from unconfirmed thresholds, labels, and scientific assumptions.
- It produces code together with the inputs, outputs, assumptions, and checks that explain the change.

## Install

```bash
npx skills add DaXuanGarden/daxuan-r-writing
```

Then ask:

```text
Read the R scripts and inputs in this project, identify the objects and key IDs,
then repair the code and run the relevant checks.
```

## Using reference code

Give the reference material and the current goal together. The skill identifies what the example reads, returns, and depends on; maps those objects to the current project; reuses only the portable parts; and lists parameters that still need confirmation. It does not silently inherit the example's filters or biological interpretation.

## Companion skills

External skills are optional helpers that can be installed and called when a task needs them. They are not copied into this repository. See [references/skill-routing.md](references/skill-routing.md) for the source list and install templates. The project still owns its data definitions, object interfaces, parameters, and final checks.

## Example request

```text
Adapt this Seurat script to the current sample metadata. Check the object type,
cell IDs, package versions, and uncertain QC thresholds before running it.
```

Run the local checks with:

```bash
./scripts/check_skill.sh
```

See the [Chinese README](README.md) for the full workflow, boundaries, and examples.
