# Join-check example

This fixture is synthetic and contains no clinical or identifiable data. It demonstrates a common failure mode: a diagnosis table has multiple rows per `stay_id`, while the requested output must remain one row per stay.

Run it from any directory with:

```bash
Rscript examples/join-check/run_example.R
```

The script aggregates diagnosis rows first, then writes `output/cohort_flags.csv` and stops if the output duplicates a stay.
