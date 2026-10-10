# R 分析脚本骨架

按当前任务删去不需要的部分。替换项目路径、输入文件、字段名和输出文件后再运行。

```r
rm(list = ls())
gc()
setwd("/填写项目根目录的绝对路径")

# 1. 设置本步输入和输出。
input_file <- "数据目录/input.csv"
output_dir <- "tutorial/output/example"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

if (!file.exists(input_file)) {
  stop("找不到输入文件，请检查 input_file。")
}

# 2. 读入数据，先确认实际字段和数据规模。
data <- read.csv(input_file, stringsAsFactors = FALSE)
cat("读入行数：", nrow(data), "\n")
print(names(data))

# 3. 只保留本步需要的字段。
required_columns <- c("id", "time", "value")
missing_columns <- setdiff(required_columns, names(data))
if (length(missing_columns) > 0) {
  stop(paste("缺少字段：", paste(missing_columns, collapse = ", ")))
}

selected_data <- data[, required_columns, drop = FALSE]

# 4. 保存派生结果，不覆盖原始数据。
output_file <- file.path(output_dir, "selected_data.csv")
write.csv(selected_data, output_file, row.names = FALSE)
cat("输出行数：", nrow(selected_data), "\n")
cat("结果已保存到：", output_file, "\n")
```

## 使用时注意

- 示例字段仅用于展示脚本结构，必须换成实际数据中的字段。
- `rm(list = ls())` 会清空当前 R 工作区；适合独立脚本，不适合直接在已有对象的交互环境中 `source()`。
- ID 和 ICD 代码按字符读取。大文件按实际规模选择读取方法，避免不必要地读入整张原始表。
- 每次只保留与当前任务有关的检查；合并前明确数据行代表什么、使用什么键。
