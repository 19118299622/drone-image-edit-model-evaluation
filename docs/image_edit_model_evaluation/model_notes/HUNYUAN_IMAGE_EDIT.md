# HunyuanImage 指令式图像编辑 / 图生图

## 基本信息

- 模型名称：HunyuanImage-3.0 Instruct / Image-to-Image。
- 精确版本：待确认。
- 发布机构：Tencent Hunyuan。
- 官方仓库：https://github.com/Tencent-Hunyuan/HunyuanImage-3.0
- 官方模型页面：README 链接到 Hugging Face 检查点，具体版本待确认。
- 官方论文或技术报告：https://arxiv.org/abs/2509.23951
- 模型定位：原生多模态图像生成模型，官方计划和更新包含 Instruct、Image-to-Image、多轮交互等能力。
- 是否支持文本指令图像编辑：是；HunyuanImage-3-Instruct 具备图像编辑相关能力。
- 是否支持多图输入：待确认。
- 权重是否开放：是。
- 代码是否开放：是。
- 许可证：官方仓库显示 View license，具体商业条款待核验。
- 商业使用状态：待确认。
- 模型规模：官方技术报告摘要提到 MoE 80B total / 13B active；具体待测试版本需确认。
- 推荐推理精度：待确认。
- 是否存在量化版本：有蒸馏/加速相关发布，量化状态待确认。
- 官方硬件建议：待确认。
- 当前是否具备本地测试条件：当前未部署。
- 当前测试方式：腾讯混元官网在线体验。
- 测试状态：已在线测试。

## 当前已知实验记录

- 当前测试模型：HunyuanImage-3-Instruct。
- 测试平台：腾讯混元官网在线体验。
- 当前属于在线体验结果，不是本地部署结果。
- 服务端 GPU、精度、量化方式、推理框架、排队情况和纯模型推理时间：待确认。
- 当前仓库已提供 HunyuanImage-3-Instruct 输出图片文件。

## 后续测试关注点

- Instruct / Image-to-Image 是否能稳定执行“叠加航线而不重绘原图”。
- 大模型资源需求是否超出当前可用硬件。
- 许可证和商业使用边界。
