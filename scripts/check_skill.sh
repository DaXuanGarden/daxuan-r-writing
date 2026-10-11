#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ROOT/SKILL.md"
  "$ROOT/README.md"
  "$ROOT/manifest.json"
  "$ROOT/evals/trigger_cases.json"
  "$ROOT/references/script-template.md"
  "$ROOT/references/skill-routing.md"
  "$ROOT/assets/daxuan-r-writing-map.svg"
  "$ROOT/examples/join-check/run_example.R"
)

for file in "${required_files[@]}"; do
  test -f "$file" || { echo "FAIL: missing $file" >&2; exit 1; }
done

python3 -m json.tool "$ROOT/manifest.json" >/dev/null
python3 -m json.tool "$ROOT/evals/trigger_cases.json" >/dev/null

python3 - "$ROOT/manifest.json" "$ROOT/references/skill-routing.md" "$ROOT/SKILL.md" "$ROOT/README.md" "$ROOT/assets/daxuan-r-writing-map.svg" <<'PY'
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

manifest_path, routing_path, skill_path, readme_path, svg_path = map(Path, sys.argv[1:])
manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
skills = manifest.get("integrated_skills")
assert isinstance(skills, list) and skills, "integrated_skills must be a non-empty list"
domains = manifest.get("supported_data_domains")
assert isinstance(domains, list) and len(domains) >= 5, "supported_data_domains must cover multiple domains"
names = [item.get("name") for item in skills]
assert len(names) == len(set(names)), "integrated skill names must be unique"
for item in skills:
    assert all(item.get(key) for key in ("name", "source", "path", "purpose")), item

routing = routing_path.read_text(encoding="utf-8")
missing = [name for name in names if f"`{name}`" not in routing]
assert not missing, f"routing document is missing: {missing}"
skill = skill_path.read_text(encoding="utf-8")
assert "外部助手怎么参与" in skill
assert "参考材料怎样变成新代码" in skill
assert "参考代码" in routing and "数据域适配" in routing
readme = readme_path.read_text(encoding="utf-8")
assert "外部助手" in readme
assert "assets/daxuan-r-writing-map.svg" in readme
assert "flowchart LR" in readme
svg_root = ET.parse(svg_path).getroot()
assert svg_root.tag.endswith("svg") and svg_root.get("role") == "img"
assert svg_root.find("{http://www.w3.org/2000/svg}title") is not None
print(f"PASS: {len(names)} integrated skill routes, {len(domains)} data domains, and documentation checks")
PY

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
