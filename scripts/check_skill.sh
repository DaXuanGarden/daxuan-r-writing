#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ROOT/SKILL.md"
  "$ROOT/README.md"
  "$ROOT/manifest.json"
  "$ROOT/evals/trigger_cases.json"
  "$ROOT/references/script-template.md"
  "$ROOT/examples/join-check/run_example.R"
)

for file in "${required_files[@]}"; do
  test -f "$file" || { echo "FAIL: missing $file" >&2; exit 1; }
done

python3 -m json.tool "$ROOT/manifest.json" >/dev/null
python3 -m json.tool "$ROOT/evals/trigger_cases.json" >/dev/null

if ! command -v Rscript >/dev/null 2>&1; then
  echo "FAIL: Rscript is required to run the reproducible example" >&2
  exit 1
fi

Rscript "$ROOT/examples/join-check/run_example.R"
python3 - "$ROOT/examples/join-check/output/cohort_flags.csv" <<'PY'
import csv
import sys

with open(sys.argv[1], newline="", encoding="utf-8") as handle:
    rows = list(csv.DictReader(handle))

stay_ids = [row["stay_id"] for row in rows]
assert len(rows) == 3, f"expected 3 rows, got {len(rows)}"
assert len(stay_ids) == len(set(stay_ids)), "stay_id is duplicated"
assert rows[0]["heart_failure"] == "1", "synthetic flag check failed"
print("PASS: JSON, R example, and output checks")
PY
