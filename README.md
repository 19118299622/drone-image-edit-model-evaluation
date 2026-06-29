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
- HunyuanImage-3-Instruct 当前测试平台：腾讯混元官网在线体验。
- 当前已具备记录的实际测试方式包括：BAGEL 本地测试、Qwen-Image-Edit ModelScope 在线测试、HunyuanImage-3-Instruct 腾讯混元官网在线测试。

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
- Qwen-Image-Edit：ModelScope 魔搭社区在线体验；当前仓库已提供输出图片文件。
- HunyuanImage-3-Instruct：腾讯混元官网在线体验；当前仓库已提供输出图片文件。

待测试或仅资料调研：

- FLUX.1 Kontext [dev]
- Step1X-Edit
- OmniGen2
- FireRed-Image-Edit

## 目录约定

```text
inputs/
├── source_images/          # 原始输入图片
├── reference_outputs/      # 参考效果图片
└── current_outputs/        # 模型实际输出或在线测试截图
    ├── bagel/
    ├── hunyuanimage3-instruct/
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

统一 Prompt 主定义位于 `docs/image_edit_model_evaluation/TEST_PROTOCOL.md` 的“统一 Prompt 规范”章节。基础任务共享 Prompt 放在 `prompts/BASIC_TASK_PROMPTS.md`，优化任务共享 Prompt 放在 `prompts/OPTIMIZED_TASK_PROMPTS.md`。四个 `prompts/TCxx_*.md` 文件只记录各测试用例的差异说明。

使用方式：

1. 需要全局同步修改 Prompt 时，只编辑统一 Prompt 主定义。
2. 需要为 `TC-01` 或 `TC-03` 新增测试 Prompt 时，只编辑 `prompts/BASIC_TASK_PROMPTS.md`。
3. 需要为 `TC-02` 或 `TC-04` 新增测试 Prompt 时，只编辑 `prompts/OPTIMIZED_TASK_PROMPTS.md`。
4. 中文阅读版只用于你自己阅读和复核，真正输入模型的是英文实际输入版。
5. 变更 Prompt 后，在 `experiment_records.csv` 中填写对应的 `prompt_id`、`prompt_version` 和结果图路径。

为了尽量不让你处理 Markdown 语法，Prompt 文件已经改成固定槽位模板。正常使用时只需要替换 `待填写`，不需要新增标题、列表或链接语法。

## 评分状态

当前尚未建立统一评分体系，不输出综合分和模型排名。当前结果以可视化对比和定性观察为主。

## 当前记录边界

- 当前三个模型的输出图片格式不一致，仓库按实际格式保留：`webp`、`png`、`jpeg`。
- 当前每次生成的详细推理参数未单独记录，统一视为默认参数。
