# 测试协议

## 目标

比较指令式图像编辑模型在建筑图片中生成无人机扫描航线示意图的视觉效果、原图保持能力、路线结构稳定性和当前可部署条件。

## 输入

- 原始建筑图片。
- 自然语言 Prompt。
- 可选参考效果图片，仅作为输出形式参考。

## 输出

- 带航线标注的图片。
- 可选实验记录，包括平台、硬件、量化方式、耗时、输出路径和结果状态。

## 当前结果记录约束

- 当前三个模型的输出图片格式不一致，现阶段按实际导出格式保留，不做统一转码。
- 当前未单独记录每次生成的详细推理参数；统一按“默认参数，未单独记录”处理。
- 在线体验结果不假设服务端硬件、精度、量化方式或推理框架。

## 当前执行原则

- 不部署大型模型。
- 不运行高显存或高耗时推理。
- 不制造不存在的模型输出。
- 不把在线体验速度和本地速度作为公平硬件对比。
- 不把输出图称为真实可执行无人机航线。

## 统一 Prompt 规范

本项目的统一 Prompt 主定义以本文件为准。后续若需要调整所有测试用例共享的 Prompt 文本、固定约束或禁用项，应优先修改本节，而不是分别修改四个测试用例文件。

### 使用方式

1. 先在本文件维护统一 Prompt 主模板和版本号。
2. `prompts/BASIC_TASK_PROMPTS.md` 维护基础任务共享 Prompt，供 `TC-01` 和 `TC-03` 共用。
3. `prompts/OPTIMIZED_TASK_PROMPTS.md` 维护优化任务共享 Prompt，供 `TC-02` 和 `TC-04` 共用。
4. 各 `TCxx` 文件只记录对应测试用例相对共享 Prompt 的差异说明。
5. 实际测试时，使用“统一 Prompt 主模板 + 共享任务 Prompt + 对应用例差异说明”组成最终输入。
6. `results/experiment_records.csv` 中使用 `test_case_id + prompt_id + run_id` 唯一标识一次测试。
7. 中文 Prompt 只用于阅读和复核；真正输入模型的是英文 Prompt。

### 统一 Prompt 版本

- 当前统一 Prompt 版本：`master-v0.1`

### 固定约束

- 保持原图中非航线区域尽量不变。
- 不重绘天空。
- 不改变建筑材料。
- 不改变门窗。
- 不改变车辆和人物。
- 不改变背景建筑。
- 不随机生成多余路线。
- 不把水平扫描路线误解为单根竖直线。
- 不生成与建筑外形无关的曲线。
- 不删除原始图片内容。
- 输出只能视为扫描路线视觉示意，不是真实可执行飞控航线。

### 通用中文 Prompt 主模板

请在这张建筑原始图片上添加无人机扫描航线示意图。保持天空、建筑表面、建筑材料、门窗、车辆、人物和背景不变，只添加清晰的航线标注。请识别主要待扫描建筑，并按照建筑可见外形绘制扫描路线。路线应包含地面环绕路线、主扫描路线、必要的辅助路线、水平扫描路线、垂直连接路线、起点、终点和方向箭头，并尽量保持路线连续、清晰、贴合建筑轮廓，不要生成随机曲线或与建筑无关的路线。请根据当前测试用例要求补充多层扫描、转角连接、顶部补扫、图例和覆盖范围等元素。输出应是一张带航线标注的视觉示意图，不是真实可执行飞行路线。

### 通用英文 Prompt 主模板

Add a drone scanning route overlay to this original building photo. Keep the sky, building surfaces, building materials, windows, doors, vehicles, people, and background unchanged, and only add clear route annotations. Identify the main target building and draw scanning routes that follow the visible building outline. The route should include a low-level perimeter route, main scanning paths, necessary auxiliary paths, horizontal scanning paths, vertical connector paths, a start point, an end point, and direction arrows, while remaining continuous, clear, and aligned with the building shape. Do not generate random curves or paths unrelated to the building. Add multi-level scanning, corner transitions, top-up scanning, a legend, and coverage-range annotations according to the current test-case requirements. The output is a visual route illustration, not an executable flight route.

### 用例变量槽位

- 建筑类型：规则建筑 / 异形建筑。
- 扫描层次：基础扫描 / 优化扫描。
- 结构重点：正立面、侧立面、转角、弧面、斜面、凹陷、突出结构。
- 是否要求 10 m 有效探测范围示意。
- 是否要求顶部补扫。
- 是否要求图例。
- 是否要求区分主扫描路线、辅助路线和覆盖范围。

### Prompt 实例填写规则

每个共享任务 Prompt 文件中已经预留了 `P01`、`P02`、`P03` 三个 Prompt 槽位。只需要填写：

- 中文阅读版。
- 英文实际输入版。
- 相对统一 Prompt 的附加要求。
- 预期观察点。

如果后续需要更多 Prompt，直接复制一个完整的“Prompt 槽位”区块，把 `prompt_id` 改成下一个编号，例如 `BASIC_P04` 或 `OPT_P04`。

## 记录模板

```text
测试用例：
测试平台：
模型版本：
运行方式：
推理耗时：
输入图片：
使用 Prompt：
输出图片：

结果观察：
- 是否识别正确目标：
- 是否生成扫描航线：
- 是否跟随建筑外形：
- 是否包含要求的关键元素：
- 是否保持原始图片：
- 是否出现明显结构错误：
- 是否出现无关重绘：
- 当前主观结论：
```

当前主观结论枚举：效果较好、基本可用、部分满足要求、效果不稳定、未满足主要要求。

## ModelScope 记录要求

Qwen-Image-Edit 当前测试方式必须记录为 ModelScope 魔搭社区在线体验。服务端 GPU、精度、量化方式、推理框架、排队情况和纯模型推理时间未公开或未知时，必须保持未知或待确认。
