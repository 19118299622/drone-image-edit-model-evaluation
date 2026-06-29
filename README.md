# 开放权重图像编辑模型评估

本仓库用于维护“开放权重图像编辑模型在无人机扫描航线可视化任务中的技术评估报告”。一级目录下的本 `README.md` 是项目主入口；`docs/image_edit_model_evaluation/` 下的 Markdown 文件是长期维护母版，PDF 或 DOCX 只作为阶段性交付版本。

## 报告入口

- 主报告：[docs/image_edit_model_evaluation/IMAGE_EDIT_MODEL_TECHNICAL_REPORT.md](docs/image_edit_model_evaluation/IMAGE_EDIT_MODEL_TECHNICAL_REPORT.md)
- 测试用例：[docs/image_edit_model_evaluation/TEST_CASES.md](docs/image_edit_model_evaluation/TEST_CASES.md)
- 测试协议：[docs/image_edit_model_evaluation/TEST_PROTOCOL.md](docs/image_edit_model_evaluation/TEST_PROTOCOL.md)
- 评分占位：[docs/image_edit_model_evaluation/SCORING_RUBRIC.md](docs/image_edit_model_evaluation/SCORING_RUBRIC.md)
- 来源记录：[docs/image_edit_model_evaluation/SOURCES.md](docs/image_edit_model_evaluation/SOURCES.md)
- 实验记录：[docs/image_edit_model_evaluation/results/experiment_records.csv](docs/image_edit_model_evaluation/results/experiment_records.csv)

## 当前测试条件

- 当前本地可部署模型：BAGEL NF4 量化版本。
- BAGEL 运行硬件：NVIDIA RTX 4070 Ti Super 16GB。
- BAGEL 单次图像编辑耗时：约 75 秒。
- Qwen-Image-Edit 当前测试平台：ModelScope 魔搭社区在线体验。
- 除 BAGEL 外，其他模型当前只完成资料调研或等待在线/服务器测试。

## 测试用例

- TC-01：规则建筑基础扫描航线生成。
- TC-02：规则建筑带 10 m 探测范围的优化航线生成。
- TC-03：异形建筑基础扫描航线生成。
- TC-04：异形建筑带 10 m 探测范围的优化航线生成。

## 当前素材

复用当前仓库已有素材：

- `inputs/source_images/regular_building_input.jpg`
- `inputs/source_images/irregular_building_input.jpg`
- `inputs/reference_outputs/TC01_reference.png`
- `inputs/reference_outputs/TC02_reference.png`
- `inputs/reference_outputs/TC03_reference.png`
- `inputs/reference_outputs/TC04_reference.png`

参考效果只能称为参考方案、qualitative reference、预期输出形式或目标效果示例，不是 Ground Truth，也不是可执行飞行路线。

## 当前模型状态

已记录实际测试条件：

- BAGEL：本地 NF4，RTX 4070 Ti Super 16GB，约 75 秒/次；当前仓库未提供输出图片文件。
- Qwen-Image-Edit：ModelScope 魔搭社区在线体验；当前仓库未提供输出图片文件或截图。

待测试或仅资料调研：

- FLUX.1 Kontext [dev]
- Step1X-Edit
- OmniGen2
- FireRed-Image-Edit
- HunyuanImage-3.0 Instruct / Image-to-Image

## 目录约定

```text
inputs/
├── source_images/          # 原始输入图片
├── reference_outputs/      # 参考效果图片
└── current_outputs/        # 模型实际输出或在线测试截图
    ├── bagel/
    └── qwen-image-edit/

docs/image_edit_model_evaluation/
├── IMAGE_EDIT_MODEL_TECHNICAL_REPORT.md
├── TEST_CASES.md
├── TEST_PROTOCOL.md
├── SCORING_RUBRIC.md
├── SOURCES.md
├── prompts/
├── model_notes/
└── results/
```

## 添加新模型结果

1. 将输出图片放入 `inputs/current_outputs/<model_name>/`。
2. 在 `docs/image_edit_model_evaluation/results/experiment_records.csv` 增加一行记录。
3. 在对应 `docs/image_edit_model_evaluation/model_notes/` 文件中补充测试环境、参数和观察。
4. 在主报告的实际测试结果章节引用图片。

## 添加新测试图片

1. 原始图片放入 `inputs/source_images/`，文件名应说明对象与用途。
2. 参考效果放入 `inputs/reference_outputs/`，文件名使用 `TCxx_reference.*`。
3. 在 `docs/image_edit_model_evaluation/TEST_CASES.md` 中增加测试用例。
4. 新增对应 Prompt 文件，并维护版本号。

## 添加 ModelScope 截图

ModelScope 在线体验截图放入 `inputs/current_outputs/qwen-image-edit/`。文件名建议：

```text
qwen_image_edit_modelscope_TCxx_YYYYMMDD.png
```

截图用途必须写清楚：测试证据、页面信息记录或结果展示。不要把截图误认为原始输入图片。

## 命名规范

- Prompt：`TCxx_short_case_name.md`
- 模型输出：`TCxx_<model>_<run_id>.png`
- 截图：`<model>_<platform>_TCxx_<date>.png`

## Prompt 版本

每个 Prompt 文件内维护版本号和修改记录。变更 Prompt 后，应在实验记录中引用对应文件路径。

## 评分状态

当前尚未建立统一评分体系，不输出综合分和模型排名。当前结果以可视化对比和定性观察为主。
