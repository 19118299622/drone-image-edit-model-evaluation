# Qwen-Image-Edit

## 基本信息

- 模型名称：Qwen-Image-Edit。
- 精确版本：当前 ModelScope 在线体验页面版本待确认。
- 发布机构：Qwen / Alibaba。
- 官方仓库：https://github.com/QwenLM/Qwen-Image
- 官方模型页：https://huggingface.co/Qwen/Qwen-Image-Edit
- ModelScope 页面：https://modelscope.cn/models/Qwen/Qwen-Image-Edit
- 官方论文或技术报告：https://arxiv.org/abs/2508.02324
- 模型定位：Qwen-Image 系列图像编辑模型。
- 是否支持文本指令图像编辑：是。
- 是否支持多图输入：原始 Qwen-Image-Edit 为单图输入；后续 Qwen-Image-Edit-2509/2511 支持多图输入，当前在线测试版本待确认。
- 权重是否开放：是。
- 代码是否开放：是。
- 许可证：官方页面记录 Qwen-Image 为 Apache-2.0。
- 商业使用状态：需按官方许可证和具体版本条款复核。
- 模型规模：Qwen-Image / Qwen-Image-Edit 系列官方说明为 20B MMDiT；若后续确认当前测试版本为 Qwen-Image-Edit-2511，则应同时记录“参数规模约 20B”与“官方完整权重文件总体积约 57 GB”，单个checkpoint下载大小为40.86GB。
- 推荐推理精度：官方示例使用 bfloat16。
- 是否存在量化版本：社区和生态支持中有低显存/FP8 等方案，当前测试未核验。
- 官方硬件建议：待确认。
- 当前是否具备本地测试条件：当前不要求本地部署。
- 当前测试方式：ModelScope 魔搭社区在线体验。
- 测试状态：已在线测试。

## 规模说明

- `20B` 表示模型参数规模，不等于实际下载体积、显存占用或运行内存占用。
- `57 GB` 表示官方发布权重文件的总体积，适合用于说明本地下载、存储和部署门槛。
- 报告里建议同时保留这两个信息，并明确二者含义不同。

## 当前已知实验记录

- 测试平台：ModelScope 魔搭社区在线体验。
- 当前属于在线体验结果，不是本地部署结果。
- 当前仓库未提供 Qwen-Image-Edit 输出图片文件或 ModelScope 截图。

## 待确认

- 精确模型版本。
- 当前在线测试版本是否确认为 Qwen-Image-Edit-2511。
- 服务端 GPU。
- 服务端精度。
- 服务端量化方式。
- 服务端推理框架。
- 纯模型推理时间。
- 端到端时间。
- 是否排队。
- 是否经过特殊加速或蒸馏。

## 当前结论边界

Qwen-Image-Edit 当前只能记录为 ModelScope 魔搭社区在线体验结果。不得写成 Hugging Face Inference Providers 或 fal，除非后续存在明确证据。
