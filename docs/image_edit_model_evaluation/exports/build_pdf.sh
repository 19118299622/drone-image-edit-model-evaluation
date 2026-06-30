#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

input="report_for_pdf.md"
output="开放权重图像编辑模型在无人机扫描航线可视化任务中的初步技术调研与测试报告_v0.1.pdf"

pandoc "$input" \
  --from markdown+pipe_tables+yaml_metadata_block+link_attributes \
  --standalone \
  --table-of-contents \
  --toc-depth=2 \
  --number-sections \
  --pdf-engine=xelatex \
  --metadata title="开放权重图像编辑模型在无人机扫描航线可视化任务中的初步技术调研与测试报告" \
  --metadata subtitle="初步调研与测试" \
  --metadata author="image_edit_model_evaluation" \
  --metadata date="2026-06-29" \
  -V mainfont="Noto Sans CJK SC" \
  -V CJKmainfont="Noto Sans CJK SC" \
  -V sansfont="Noto Sans CJK SC" \
  -V monofont="DejaVu Sans Mono" \
  -V geometry:margin=20mm \
  -V fontsize=11pt \
  -V linestretch=1.25 \
  -V colorlinks=true \
  -V linkcolor=blue \
  -V urlcolor=blue \
  -V papersize=a4 \
  -V header-includes='
\usepackage{float}
\usepackage{longtable}
\usepackage{booktabs}
\usepackage{array}
\usepackage{graphicx}
\usepackage{caption}
\usepackage{fancyhdr}
\usepackage{grffile}
\usepackage{placeins}
\usepackage{xurl}
\usepackage[hyphens]{url}
\usepackage{needspace}
\setlength{\headheight}{14pt}
\setlength{\emergencystretch}{3em}
\sloppy
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[C]{\thepage}
' \
  -o "$output"

echo "$output"
