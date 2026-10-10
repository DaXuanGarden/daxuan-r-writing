#!/usr/bin/env Rscript

rm(list = ls())
gc()

script_arg <- grep("^--file=", commandArgs(), value = TRUE)
if (length(script_arg) != 1L) {
  stop("请用 Rscript examples/join-check/run_example.R 运行此示例。")
}
example_dir <- dirname(normalizePath(sub("^--file=", "", script_arg)))
output_dir <- file.path(example_dir, "output")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

stays <- read.csv(file.path(example_dir, "stays.csv"), colClasses = "character")
diagnoses <- read.csv(file.path(example_dir, "diagnoses.csv"), colClasses = "character")

required_stays <- c("stay_id", "subject_id")
required_diagnoses <- c("stay_id", "icd_code")
missing_stays <- setdiff(required_stays, names(stays))
missing_diagnoses <- setdiff(required_diagnoses, names(diagnoses))
if (length(missing_stays) > 0L || length(missing_diagnoses) > 0L) {
  stop("输入字段不完整，请检查 stays.csv 和 diagnoses.csv。")
}
if (anyDuplicated(stays$stay_id)) {
  stop("stays.csv 必须一行一个 stay_id。")
}

# 明细先汇总为一行一个 stay，再回填到主表，避免连接放大行数。
diagnoses <- diagnoses[!is.na(diagnoses$stay_id) & !is.na(diagnoses$icd_code), , drop = FALSE]
codes_by_stay <- split(diagnoses$icd_code, diagnoses$stay_id)
get_codes <- function(stay_id) {
  codes <- codes_by_stay[[stay_id]]
  if (is.null(codes)) character() else codes
}

result <- stays
result$diagnosis_count <- vapply(result$stay_id, function(id) length(unique(get_codes(id))), integer(1))
result$heart_failure <- vapply(
  result$stay_id,
  function(id) as.integer(any(grepl("^I50", get_codes(id)))),
  integer(1)
)

if (nrow(result) != nrow(stays) || anyDuplicated(result$stay_id)) {
  stop("检查失败：结果不再是一行一个 stay_id。")
}

output_file <- file.path(output_dir, "cohort_flags.csv")
write.csv(result, output_file, row.names = FALSE, quote = FALSE)
cat("PASS: one row per stay_id (", nrow(result), " rows)\n", sep = "")
cat("Wrote: ", output_file, "\n", sep = "")
