# 开放权重图像编辑模型在无人机扫描航线可视化任务中的技术评估报告

版本：v0.1  
日期：2026-06-29  
状态：阶段性 Markdown 母版

## 目录

1. [摘要](#1-摘要)
2. [项目背景](#2-项目背景)
3. [业务目标](#3-业务目标)
4. [输入输出定义](#4-输入输出定义)
5. [当前实验条件与限制](#5-当前实验条件与限制)
6. [测试图片说明](#6-测试图片说明)
7. [四个测试用例](#7-四个测试用例)
8. [参考结果说明](#8-参考结果说明)
9. [候选模型概览](#9-候选模型概览)
10. [BAGEL 模型说明](#10-bagel-模型说明)
11. [Qwen-Image-Edit 模型说明](#11-qwen-image-edit-模型说明)
12. [其他候选模型调研](#12-其他候选模型调研)
13. [测试方式](#13-测试方式)
14. [Prompt 设计](#14-prompt-设计)
15. [实际测试结果展示](#15-实际测试结果展示)
16. [规则建筑结果对比](#16-规则建筑结果对比)
17. [异形建筑结果对比](#17-异形建筑结果对比)
18. [基础任务与优化任务对比](#18-基础任务与优化任务对比)
19. [推理速度与部署条件](#19-推理速度与部署条件)
20. [生成式图像编辑方案的优势](#20-生成式图像编辑方案的优势)
21. [生成式图像编辑方案的局限](#21-生成式图像编辑方案的局限)
22. [替代或混合技术路线](#22-替代或混合技术路线)
23. [当前说明](#23-当前说明)
24. [后续工作](#24-后续工作)
25. [参考资料](#25-参考资料)

## 1. 摘要

本报告评估开放权重图像编辑模型在“给建筑图片叠加无人机扫描航线示意图”任务中的可行性。当前阶段不是严格学术 benchmark，不输出综合分或模型排名，重点是建立可持续维护的 Markdown 报告结构，展示输入图片、Prompt、参考效果、模型输出位置、测试方式和已知限制。

当前已知：BAGEL NF4 可在本地 NVIDIA RTX 4070 Ti Super 16GB 上完成图像编辑，单次约 75 秒；Qwen-Image-Edit 当前通过 ModelScope 魔搭社区在线体验测试；HunyuanImage-3-Instruct 当前通过腾讯混元官网在线体验测试。当前仓库未提供这三个模型的实际输出图片文件，因此本版报告只展示原始图片与参考效果，并为模型输出保留明确位置。

## 2. 项目背景

无人机建筑扫描任务需要把扫描目标、覆盖方式和飞行方向清晰表达出来。生成式图像编辑模型可以直接根据图片和自然语言 Prompt 输出带航线标注的图片，适合作为低成本原型验证方式。

但该类输出本质是像素图，不能直接作为飞控航点。真实飞行仍需要尺度、相机参数、点云、Mesh、BIM、多视角信息、障碍物和无人机运动约束。

## 3. 业务目标

本阶段目标是评估模型是否能：

- 识别规则建筑和异形建筑。
- 按 Prompt 在原图上绘制扫描航线。
- 表达主扫描路线、辅助路线、补扫路线、方向箭头、起点和终点。
- 在优化任务中表达 10 m 探测范围概念。
- 尽量保持原始图片中非航线区域不变。
- 为后续“视觉理解 + 结构化路线 + 确定性绘制”路线提供判断依据。

## 4. 输入输出定义

输入：

- 建筑或其他无人机待扫描目标的原始图片。
- 描述扫描目标、扫描方式和覆盖要求的自然语言 Prompt。

输出：

- 带无人机扫描航线标注的图片。
- 航线可以包含主扫描路径、辅助路径、补扫路径、方向箭头、起点、终点和覆盖范围。

输出边界：当前输出是视觉示意图，不是真实可执行无人机航线。

## 5. 当前实验条件与限制

- 当前无法使用公司服务器或高显存云端服务器。
- 当前本地硬件能够部署的模型只有 BAGEL NF4 量化版本。
- BAGEL 当前运行硬件为 NVIDIA RTX 4070 Ti Super 16GB。
- BAGEL NF4 当前单次图像编辑约为 75 秒。
- 其他大型模型目前不要求本地部署。
- Qwen-Image-Edit 当前通过 ModelScope 魔搭社区在线体验页面测试。
- ModelScope 在线体验的 GPU、精度、推理框架和服务端优化通常未知。
- 当前没有成熟、统一的人工评分标准。

## 6. 测试图片说明

### 规则建筑原始图片

![规则建筑原始图片](../../inputs/source_images/regular_building_input.jpg)

用途：TC-01 和 TC-02 的原始输入图片，不带航线标注。

### 异形建筑原始图片

![异形建筑原始图片](../../inputs/source_images/irregular_building_input.jpg)

用途：TC-03 和 TC-04 的原始输入图片，不带航线标注。

## 7. 四个测试用例

完整定义见 [TEST_CASES.md](TEST_CASES.md)。

- TC-01：规则建筑基础扫描航线生成。
- TC-02：规则建筑带 10 m 探测范围的优化航线生成。
- TC-03：异形建筑基础扫描航线生成。
- TC-04：异形建筑带 10 m 探测范围的优化航线生成。

## 8. 参考结果说明

以下图片是参考方案、qualitative reference、预期输出形式或目标效果示例。它们不是唯一正确答案，不是 Ground Truth，不是真实最短路径，也不是可直接执行航线。

| 用例 | 参考效果 |
| --- | --- |
| TC-01 | ![TC-01 参考效果](../../inputs/reference_outputs/TC01_reference.png) |
| TC-02 | ![TC-02 参考效果](../../inputs/reference_outputs/TC02_reference.png) |
| TC-03 | ![TC-03 参考效果](../../inputs/reference_outputs/TC03_reference.png) |
| TC-04 | ![TC-04 参考效果](../../inputs/reference_outputs/TC04_reference.png) |

## 9. 候选模型概览

| 模型 | 发布机构 | 指令式图像编辑 | 权重开放 | 许可证 | 当前测试方式 | 测试状态 |
| --- | --- | --- | --- | --- | --- | --- |
| BAGEL | ByteDance-Seed | 是 | 是 | Apache-2.0 | 本地 NF4 | 已本地测试 |
| Qwen-Image-Edit | Qwen / Alibaba | 是 | 是 | Apache-2.0 | ModelScope 在线体验 | 已在线测试 |
| HunyuanImage-3-Instruct | Tencent Hunyuan | 是 | 是 | 待确认 | 腾讯混元官网在线体验 | 已在线测试 |
| FLUX.1 Kontext [dev] | Black Forest Labs | 是 | 是 | FLUX.1 [dev] Non-Commercial License | 资料调研 | 仅完成资料调研 |
| Step1X-Edit | StepFun AI | 是 | 是 | Apache-2.0 | 资料调研 | 仅完成资料调研 |
| OmniGen2 | VectorSpaceLab / BAAI 相关项目 | 是，待接口复核 | 是 | Apache-2.0 | 资料调研 | 仅完成资料调研 |
| FireRed-Image-Edit | FireRedTeam | 是 | 是 | Apache-2.0 | 资料调研 | 仅完成资料调研 |

不要将“开放权重”等同于“允许商业使用”。商业使用状态需要按官方许可证和公司合规要求复核。

## 10. BAGEL 模型说明

详细记录见 [model_notes/BAGEL.md](model_notes/BAGEL.md)。

官方详情：

- GitHub：https://github.com/ByteDance-Seed/Bagel
- Hugging Face：https://huggingface.co/ByteDance-Seed/BAGEL-7B-MoT

BAGEL 是 ByteDance-Seed 发布的统一多模态理解与生成模型，支持图像编辑。本项目当前使用本地 NF4 量化版本，在 NVIDIA RTX 4070 Ti Super 16GB 上单次图像编辑约 75 秒。仍待确认推理步数、Guidance、分辨率、CPU offload、峰值显存和重复运行平均耗时。

## 11. Qwen-Image-Edit 模型说明

详细记录见 [model_notes/QWEN_IMAGE_EDIT.md](model_notes/QWEN_IMAGE_EDIT.md)。

官方详情：

- GitHub：https://github.com/QwenLM/Qwen-Image
- Hugging Face：https://huggingface.co/Qwen/Qwen-Image-Edit
- ModelScope：https://modelscope.cn/models/Qwen/Qwen-Image-Edit

Qwen-Image-Edit 当前测试方式必须写为 ModelScope 魔搭社区在线体验。当前不能写成 Hugging Face Inference Providers 或 fal。在线体验的服务端硬件、精度、量化方式、推理框架、排队情况和纯模型推理时间均待确认。

如果后续确认当前测试版本为 Qwen-Image-Edit-2511，建议在模型说明中同时记录“参数规模约 20B”和“官方完整权重文件总体积约 57 GB”。前者用于描述模型规模，后者用于描述下载和部署门槛，两者不能混写为同一指标。

## 12. 其他候选模型调研

详细记录：

- [FLUX_KONTEXT.md](model_notes/FLUX_KONTEXT.md)
- [STEP1X_EDIT.md](model_notes/STEP1X_EDIT.md)
- [OMNIGEN2.md](model_notes/OMNIGEN2.md)
- [FIRERED_IMAGE_EDIT.md](model_notes/FIRERED_IMAGE_EDIT.md)
- [HUNYUAN_IMAGE_EDIT.md](model_notes/HUNYUAN_IMAGE_EDIT.md)

除 HunyuanImage-3-Instruct 外，这些模型当前未在本项目素材上完成测试，不生成效果结论。

## 13. 测试方式

当前测试记录模板见 [TEST_PROTOCOL.md](TEST_PROTOCOL.md)。每个结果需要记录测试用例、平台、模型版本、运行方式、推理耗时、输入图片、Prompt、输出图片和定性观察。

## 14. Prompt 设计

统一 Prompt 主定义以 [TEST_PROTOCOL.md](TEST_PROTOCOL.md) 中的“统一 Prompt 规范”为准。后续若需要同步修改所有测试用例共享的 Prompt 文本、固定约束或禁用项，只修改该处。

Prompt 文件组织方式：

- [BASIC_TASK_PROMPTS.md](prompts/BASIC_TASK_PROMPTS.md)：基础任务共享 Prompt，供 TC-01 与 TC-03 共用。
- [OPTIMIZED_TASK_PROMPTS.md](prompts/OPTIMIZED_TASK_PROMPTS.md)：优化任务共享 Prompt，供 TC-02 与 TC-04 共用。
- [TC01_regular_building_basic.md](prompts/TC01_regular_building_basic.md)：TC-01 差异说明。
- [TC02_regular_building_optimized.md](prompts/TC02_regular_building_optimized.md)：TC-02 差异说明。
- [TC03_irregular_building_basic.md](prompts/TC03_irregular_building_basic.md)：TC-03 差异说明。
- [TC04_irregular_building_optimized.md](prompts/TC04_irregular_building_optimized.md)：TC-04 差异说明。

使用方式：

1. 先读取 `TEST_PROTOCOL.md` 中的统一 Prompt 主模板。
2. 对基础任务读取 `BASIC_TASK_PROMPTS.md`，对优化任务读取 `OPTIMIZED_TASK_PROMPTS.md`。
3. 再读取对应 `TCxx` 文件中的差异说明。
4. 中文阅读版用于复核，英文实际输入版用于模型测试。
5. 将统一 Prompt 主模板、共享任务 Prompt 与 case 差异说明组合为实际测试输入。

这样可以保证未来只维护一个统一 Prompt 主文件，同时支持同一测试用例下的多个 Prompt 版本对比。

## 15. 实际测试结果展示

当前已接入三种模型的实际输出图：

- BAGEL：本地 NF4，默认参数未单独记录，输出格式为 `webp`。
- Qwen-Image-Edit：ModelScope 魔搭社区在线体验，默认参数未单独记录，输出格式为 `png`。
- HunyuanImage-3-Instruct：腾讯混元官网在线体验，默认参数未单独记录，输出格式为 `jpeg`。

三种模型的输出格式和分辨率当前不一致，报告阶段按原始导出结果保留，不做统一转码。

已测试模型官方详情：

- BAGEL：GitHub `https://github.com/ByteDance-Seed/Bagel`，Hugging Face `https://huggingface.co/ByteDance-Seed/BAGEL-7B-MoT`
- Qwen-Image-Edit：GitHub `https://github.com/QwenLM/Qwen-Image`，Hugging Face `https://huggingface.co/Qwen/Qwen-Image-Edit`
- HunyuanImage-3-Instruct：GitHub `https://github.com/Tencent-Hunyuan/HunyuanImage-3.0`，腾讯混元官网在线体验

### TC-01 / 直译版

原始图片：

![TC-01 输入](../../inputs/source_images/regular_building_input.jpg)

参考效果：

![TC-01 参考效果](../../inputs/reference_outputs/TC01_reference.png)

BAGEL：

![TC-01 直译版 BAGEL](../../inputs/current_outputs/bagel/TC01_BASIC_P01_bagel_R01.webp)

Qwen-Image-Edit：

![TC-01 直译版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC01_BASIC_P01_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-01 直译版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC01_BASIC_P01_hunyuan_R01.jpeg)

### TC-01 / 针对图像编辑模型优化版

原始图片：

![TC-01 输入](../../inputs/source_images/regular_building_input.jpg)

参考效果：

![TC-01 参考效果](../../inputs/reference_outputs/TC01_reference.png)

BAGEL：

![TC-01 优化版 BAGEL](../../inputs/current_outputs/bagel/TC01_BASIC_P02_bagel_R01.webp)

Qwen-Image-Edit：

![TC-01 优化版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC01_BASIC_P02_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-01 优化版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC01_BASIC_P02_hunyuan_R01.jpeg)

### TC-02 / 直译版

原始图片：

![TC-02 输入](../../inputs/source_images/regular_building_input.jpg)

参考效果：

![TC-02 参考效果](../../inputs/reference_outputs/TC02_reference.png)

BAGEL：

![TC-02 直译版 BAGEL](../../inputs/current_outputs/bagel/TC02_OPT_P01_bagel_R01.webp)

Qwen-Image-Edit：

![TC-02 直译版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC02_OPT_P01_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-02 直译版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC02_OPT_P01_hunyuan_R01.jpeg)

### TC-02 / 针对图像编辑模型优化版

原始图片：

![TC-02 输入](../../inputs/source_images/regular_building_input.jpg)

参考效果：

![TC-02 参考效果](../../inputs/reference_outputs/TC02_reference.png)

BAGEL：

![TC-02 优化版 BAGEL](../../inputs/current_outputs/bagel/TC02_OPT_P02_bagel_R01.webp)

Qwen-Image-Edit：

![TC-02 优化版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC02_OPT_P02_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-02 优化版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC02_OPT_P02_hunyuan_R01.jpeg)

### TC-03 / 直译版

原始图片：

![TC-03 输入](../../inputs/source_images/irregular_building_input.jpg)

参考效果：

![TC-03 参考效果](../../inputs/reference_outputs/TC03_reference.png)

BAGEL：

![TC-03 直译版 BAGEL](../../inputs/current_outputs/bagel/TC03_BASIC_P01_bagel_R01.webp)

Qwen-Image-Edit：

![TC-03 直译版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC03_BASIC_P01_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-03 直译版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC03_BASIC_P01_hunyuan_R01.jpeg)

### TC-03 / 针对图像编辑模型优化版

原始图片：

![TC-03 输入](../../inputs/source_images/irregular_building_input.jpg)

参考效果：

![TC-03 参考效果](../../inputs/reference_outputs/TC03_reference.png)

BAGEL：

![TC-03 优化版 BAGEL](../../inputs/current_outputs/bagel/TC03_BASIC_P02_bagel_R01.webp)

Qwen-Image-Edit：

![TC-03 优化版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC03_BASIC_P02_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-03 优化版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC03_BASIC_P02_hunyuan_R01.jpeg)

### TC-04 / 直译版

原始图片：

![TC-04 输入](../../inputs/source_images/irregular_building_input.jpg)

参考效果：

![TC-04 参考效果](../../inputs/reference_outputs/TC04_reference.png)

BAGEL：

![TC-04 直译版 BAGEL](../../inputs/current_outputs/bagel/TC04_OPT_P01_bagel_R01.webp)

Qwen-Image-Edit：

![TC-04 直译版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC04_OPT_P01_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-04 直译版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC04_OPT_P01_hunyuan_R01.jpeg)

### TC-04 / 针对图像编辑模型优化版

原始图片：

![TC-04 输入](../../inputs/source_images/irregular_building_input.jpg)

参考效果：

![TC-04 参考效果](../../inputs/reference_outputs/TC04_reference.png)

BAGEL：

![TC-04 优化版 BAGEL](../../inputs/current_outputs/bagel/TC04_OPT_P02_bagel_R01.webp)

Qwen-Image-Edit：

![TC-04 优化版 Qwen](../../inputs/current_outputs/qwen-image-edit/TC04_OPT_P02_qwen_R01.png)

HunyuanImage-3-Instruct：

![TC-04 优化版 Hunyuan](../../inputs/current_outputs/hunyuanimage3-instruct/TC04_OPT_P02_hunyuan_R01.jpeg)

## 16. 规则建筑结果对比

规则建筑结果展示对应：

- `TC-01 / 直译版`
- `TC-01 / 针对图像编辑模型优化版`
- `TC-02 / 直译版`
- `TC-02 / 针对图像编辑模型优化版`

## 17. 异形建筑结果对比

异形建筑结果展示对应：

- `TC-03 / 直译版`
- `TC-03 / 针对图像编辑模型优化版`
- `TC-04 / 直译版`
- `TC-04 / 针对图像编辑模型优化版`

## 18. 基础任务与优化任务对比

基础任务结果展示对应：

- `TC-01 / 直译版`
- `TC-01 / 针对图像编辑模型优化版`
- `TC-03 / 直译版`
- `TC-03 / 针对图像编辑模型优化版`

优化任务结果展示对应：

- `TC-02 / 直译版`
- `TC-02 / 针对图像编辑模型优化版`
- `TC-04 / 直译版`
- `TC-04 / 针对图像编辑模型优化版`

限制：单张普通图片无法恢复建筑真实尺度、完整深度和准确物理距离。10 m 覆盖范围只评价视觉上合理的覆盖优化示意，不验证真实距离，也不证明全局最短路径。

## 19. 推理速度与部署条件

| 模型 | 当前方式 | 硬件 | 量化/精度 | 耗时 | 说明 |
| --- | --- | --- | --- | --- | --- |
| BAGEL | 本地 | NVIDIA RTX 4070 Ti Super 16GB | NF4 | 约 75 秒/次 | 是否包含加载、预热和具体参数待确认 |
| Qwen-Image-Edit | ModelScope 在线体验 | 未公开 | 未知 | 待确认 | 不可与本地 BAGEL 直接公平对比 |
| HunyuanImage-3-Instruct | 腾讯混元官网在线体验 | 未公开 | 未知 | 待确认 | 在线体验结果，不可与本地 BAGEL 直接公平对比 |
| FLUX.1 Kontext [dev] | 未测试 | 待服务器资源 | 待确认 | 待测试 | 仅资料调研 |
| Step1X-Edit | 未测试 | 待服务器资源 | 待确认 | 待测试 | 仅资料调研 |
| OmniGen2 | 未测试 | 待服务器资源 | 待确认 | 待测试 | 仅资料调研 |
| FireRed-Image-Edit | 未测试 | 待服务器资源 | 待确认 | 待测试 | 仅资料调研 |

## 20. 生成式图像编辑方案的优势

- 原型实现快。
- 能够直接理解自然语言 Prompt。
- 对不同建筑外形可能具有一定泛化能力。
- 输出直观，便于非技术人员理解。
- 适合快速探索“用户想看到什么样的航线表达”。

## 21. 生成式图像编辑方案的局限

- 可能修改原图非航线区域。
- 路线结构不稳定。
- 推理延迟较高。
- 输出只有像素，缺少可验证路线数据。
- 难以直接进入飞控系统。
- 单张图片无法提供真实尺度、深度、遮挡和障碍物信息。

## 22. 替代或混合技术路线

### 路线 A：生成式图像编辑

```text
图片 + 文本 Prompt
        ↓
图像编辑模型
        ↓
带航线标注的图片
```

路线 A 适合快速生成视觉示意，但输出难以验证和复用。

### 路线 B：视觉理解 + 路线数据 + 确定性绘制

```text
图片 + 文本 Prompt
        ↓
VLM / 分割 / 深度 / 几何分析
        ↓
结构化路线控制点
        ↓
OpenCV / SVG / Canvas
        ↓
路线数据 + 预览图片
```

OpenCV 只负责最终绘制，不负责理解异形建筑。异形建筑理解来自视觉模型和几何建模。结构化路线更容易检查、修改、复现和接入后续系统。图片应是路线数据的可视化结果，而不是唯一输出。

真实飞行仍需要尺度、相机参数、点云、Mesh、BIM、多视角信息、障碍物和无人机运动约束。

## 23. 当前说明

1. 当前报告以图片结果展示为核心，不输出总排名和综合分。
2. 三种模型的输出格式和分辨率当前不一致，按原始导出结果保留。
3. 当前每次生成均按默认参数处理，未单独记录详细推理参数。
4. 在线体验结果不能与本地 BAGEL 构成严格公平的硬件性能对比。
5. 当前模型输出属于无人机扫描路线示意图，不是可执行飞控航点。

## 24. 后续工作

- 在服务器资源可用后测试 FLUX.1 Kontext [dev]、Step1X-Edit、OmniGen2、FireRed-Image-Edit。
- 如有需要，再补充更完整的人工观察和筛选结论。
- 评估“视觉理解 + 结构化路线 + 确定性绘制”的混合方案。

## 25. 参考资料

来源明细见 [SOURCES.md](SOURCES.md)。
