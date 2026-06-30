# 执行摘要

当前目标是根据建筑图片和文本要求，生成无人机扫描航线示意图，并直接绘制在输入图片上。当前使用两张建筑图片和四个递进测试用例，共测试三种已具备图像编辑能力的开放权重模型或开放体验模型：BAGEL、Qwen-Image-Edit、HunyuanImage-3-Instruct。

BAGEL 已在 NVIDIA RTX 4070 Ti Super 16GB 上以 NF4 量化方式完成本地测试，当前单次图像编辑约 75 秒。Qwen-Image-Edit 通过 ModelScope 魔搭社区在线体验测试，HunyuanImage-3-Instruct 通过腾讯混元官网在线体验测试。由于三者运行环境不同，当前结果不能构成严格公平的性能排名，因此本报告以生成结果的直观展示和定性对照为主。

当前尚未建立统一评分体系，详细推理参数也未单独记录，默认按各平台默认参数处理。当前生成结果属于无人机扫描路线示意图，不是可直接下发飞控的真实航点。是否继续采用生成式图像编辑作为主技术路线，仍需结合下游真实输出需求进一步判断。

# 项目背景与业务目标

本项目关注的业务问题是：输入建筑图片和自然语言要求后，能否由图像编辑模型直接输出一张带有无人机扫描航线标注的图片，用于表达扫描对象、覆盖方式、主路线、补扫路线和方向。

当前评估重点包括：

- 模型是否能识别规则建筑和异形建筑。
- 模型是否能根据 Prompt 在原图上叠加扫描路线。
- 模型是否能表达基础任务与优化任务的差异。
- 模型是否会明显破坏原图。
- 生成式图像编辑路线是否适合作为业务原型方案。

# 当前实验条件与限制

- 当前本地可部署模型：BAGEL NF4。
- 本地硬件：NVIDIA RTX 4070 Ti Super 16GB。
- BAGEL 当前单次图像编辑约 75 秒。
- Qwen-Image-Edit 当前测试方式：ModelScope 魔搭社区在线体验。
- HunyuanImage-3-Instruct 当前测试方式：腾讯混元官网在线体验。
- 当前三种模型的输出格式不一致：BAGEL 为 `webp`，Qwen 为 `png`，Hunyuan 为 `jpeg`。
- 当前每次生成的详细推理参数未单独记录，统一按默认参数处理。
- 在线体验结果不与本地 BAGEL 做严格公平的硬件性能对比。

# 测试图片与任务设置

## 测试图片

规则建筑原始图：

![](../../../inputs/source_images/regular_building_input.jpg){ width=62% }

异形建筑原始图：

![](../../../inputs/source_images/irregular_building_input.jpg){ width=62% }

## 四个递进任务

- `TC-01`：规则建筑基础扫描航线生成。
- `TC-02`：规则建筑带 10 m 探测范围的优化航线生成。
- `TC-03`：异形建筑基础扫描航线生成。
- `TC-04`：异形建筑带 10 m 探测范围的优化航线生成。

## Prompt 组织方式

- 基础任务共享 Prompt：适用于 `TC-01` 与 `TC-03`
- 优化任务共享 Prompt：适用于 `TC-02` 与 `TC-04`
- 当前实际展示使用两种 Prompt 备注：
  - `直译版`
  - `针对图像编辑模型优化版`

# 当前测试使用的 Prompt

## 基础任务共享 Prompt

适用测试用例：`TC-01`、`TC-03`

### 直译版

中文阅读版：

我现在想使用无人机对画面中的白色建筑进行扫描和三维重建。请根据图片中的建筑外形和可见结构，给出无人机的扫描飞行轨迹，并将二维轨迹直接绘制在输入图片上，最终输出完整的编辑后图片。

英文实际输入版：

I want to use a drone to scan and reconstruct the white building shown in the image in 3D. Based on the building shape and visible structure in the image, generate a drone scanning flight trajectory, draw the two-dimensional trajectory directly onto the input image, and output the complete edited image.

### 针对图像编辑模型优化版

中文阅读版：

在原始照片上叠加一套紧凑、连续、清晰且视觉上合理的无人机优化扫描航线。唯一的扫描目标是画面中的白色主体建筑。

假设无人机传感器能够在所有方向有效探测距离航线 10 米以内的建筑表面。使用尽可能少的主扫描路线覆盖较大的连续立面和主要可见表面，并减少重复扫描、回头、交叉和无效绕行。当一条航线的 10 米探测范围能够覆盖相邻区域时，不再增加重复的平行路线。

在建筑附近的地面区域设置一个绿色圆形起点。使用高对比度红色虚线绘制主扫描路线，并沿路线添加小型红色方向箭头。主路线应位于建筑外侧，并沿正立面、侧立面、转角和主要轮廓连续延伸。

对于屋顶、凹陷区域、倾斜表面、弧面、突出结构或主路线难以覆盖的位置，仅添加少量必要的辅助补扫路径。主路线和辅助路线应连接成一条连续、高效且容易理解的飞行轨迹。

可以使用半透明红色圆弧、局部覆盖圆或覆盖带表达 10 米探测范围。可以通过不同线型或简洁图例区分主路线、辅助路线和探测覆盖范围。航线应符合建筑外形和图片透视，并明显表现出减少扫描层数、重复路径和总飞行距离的优化意图。

完整保留原始照片。只添加航线、方向箭头、起点、必要的覆盖范围和简洁图例。

不要重绘、变形、移动、替换或重新设计建筑。不要改变建筑材质、颜色、门窗、屋顶和结构。不要修改天空、地面、车辆、人物、树木、背景、光照、构图、清晰度或图片风格。不要添加实体无人机、新建筑、新车辆、新人物或其他无关物体。

不要生成大量平行航线、密集扫描层、重复环绕、重复扫描、无意义回头、过多转弯、长距离绕行、杂乱交叉或随机曲线。不要生成穿墙路线、穿过建筑内部的路线、悬空路线、断裂路线或与建筑轮廓无关的路线。不要只生成一根无法覆盖主要表面的简单直线或一根中央竖线。

不要遗漏主路线、必要补扫路线、方向箭头或起点。不要让覆盖范围遮挡整栋建筑。不要使用过大的覆盖圆、过粗的线条、实线航线、巨大图例或大段文字。

英文实际输入版：

Overlay a compact, continuous, clear, and visually plausible optimized drone scanning trajectory on the original photograph. The only scanning target is the main white building in the image.

Assume that the drone sensor can effectively observe building surfaces within 10 meters in every direction from the flight path. Use as few main scanning routes as reasonably possible to cover large continuous facades and the main visible surfaces, while reducing repeated scanning, backtracking, crossings, and unnecessary detours. When the 10-meter sensing range of one route can cover an adjacent area, avoid adding a duplicate parallel route.

Place one green circular start marker on the ground near the building. Draw the main scanning route with high-contrast bright red dashed lines and add small red directional arrowheads along it. Keep the main route outside the building and continuously follow the front facade, side facade, corners, and major visible outline.

Add only a small number of necessary supplementary routes for the roof, recessed regions, inclined surfaces, curved surfaces, protruding structures, or areas that are difficult to cover from the main route. Connect the main and supplementary routes into one continuous, efficient, and easy-to-understand flight trajectory.

Use semi-transparent red arcs, local coverage circles, or coverage bands to represent the 10-meter sensing range. Different line styles or a simple legend may distinguish the main route, supplementary routes, and sensing coverage. Match the building shape and image perspective, and clearly express the intention to reduce scanning levels, duplicate routes, and total flight distance.

Preserve the complete original photograph. Add only the trajectory, directional arrows, start marker, necessary sensing-range visualization, and a simple legend.

Do not repaint, deform, move, replace, or redesign the building. Do not change its materials, colors, windows, doors, roof, or structure. Do not modify the sky, ground, vehicles, people, trees, background, lighting, composition, clarity, or image style. Do not add physical drones, new buildings, new vehicles, new people, or unrelated objects.

Do not generate large numbers of parallel routes, dense scanning levels, repeated orbits, repeated scanning, meaningless backtracking, excessive turns, long detours, chaotic crossings, or random curves. Do not generate routes passing through walls or the building interior, floating paths, disconnected paths, or routes unrelated to the building outline. Do not generate only one simple line that cannot cover the main surfaces or one vertical line through the center of the building.

Do not omit the main route, necessary supplementary routes, directional arrows, or start marker. Do not allow sensing-range graphics to cover the entire building. Avoid oversized coverage circles, excessively thick lines, solid trajectory lines, oversized legends, or large text blocks.

## 优化任务共享 Prompt

适用测试用例：`TC-02`、`TC-04`

### 直译版

中文阅读版：

假设无人机的探测范围为全向 10 米，请给出能够最快完成整个建筑物扫描的飞行轨迹，并将轨迹绘制在输入图片中，最终输出完整图片。

英文实际输入版：

Assume that the drone has an omnidirectional sensing range of 10 meters. Generate a flight trajectory that can complete the scan of the entire building as quickly as possible, draw the trajectory on the input image, and output the complete image.

### 针对图像编辑模型优化版

中文阅读版：

在原始照片上叠加一套紧凑、连续、清晰且视觉上合理的无人机优化扫描航线。唯一的扫描目标是画面中的白色主体建筑。

假设无人机传感器能够在所有方向有效探测距离航线 10 米以内的建筑表面。使用尽可能少的主扫描路线覆盖较大的连续立面和主要可见表面，并减少重复扫描、回头、交叉和无效绕行。当一条航线的 10 米探测范围能够覆盖相邻区域时，不再增加重复的平行路线。

在建筑附近的地面区域设置一个绿色圆形起点。使用高对比度红色虚线绘制主扫描路线，并沿路线添加小型红色方向箭头。主路线应位于建筑外侧，并沿正立面、侧立面、转角和主要轮廓连续延伸。

对于屋顶、凹陷区域、倾斜表面、弧面、突出结构或主路线难以覆盖的位置，仅添加少量必要的辅助补扫路径。主路线和辅助路线应连接成一条连续、高效且容易理解的飞行轨迹。

可以使用半透明红色圆弧、局部覆盖圆或覆盖带表达 10 米探测范围。可以通过不同线型或简洁图例区分主路线、辅助路线和探测覆盖范围。航线应符合建筑外形和图片透视，并明显表现出减少扫描层数、重复路径和总飞行距离的优化意图。

完整保留原始照片。只添加航线、方向箭头、起点、必要的覆盖范围和简洁图例。

不要重绘、变形、移动、替换或重新设计建筑。不要改变建筑材质、颜色、门窗、屋顶和结构。不要修改天空、地面、车辆、人物、树木、背景、光照、构图、清晰度或图片风格。不要添加实体无人机、新建筑、新车辆、新人物或其他无关物体。

不要生成大量平行航线、密集扫描层、重复环绕、重复扫描、无意义回头、过多转弯、长距离绕行、杂乱交叉或随机曲线。不要生成穿墙路线、穿过建筑内部的路线、悬空路线、断裂路线或与建筑轮廓无关的路线。不要只生成一根无法覆盖主要表面的简单直线或一根中央竖线。

不要遗漏主路线、必要补扫路线、方向箭头或起点。不要让覆盖范围遮挡整栋建筑。不要使用过大的覆盖圆、过粗的线条、实线航线、巨大图例或大段文字。

英文实际输入版：

Overlay a compact, continuous, clear, and visually plausible optimized drone scanning trajectory on the original photograph. The only scanning target is the main white building in the image.

Assume that the drone sensor can effectively observe building surfaces within 10 meters in every direction from the flight path. Use as few main scanning routes as reasonably possible to cover large continuous facades and the main visible surfaces, while reducing repeated scanning, backtracking, crossings, and unnecessary detours. When the 10-meter sensing range of one route can cover an adjacent area, avoid adding a duplicate parallel route.

Place one green circular start marker on the ground near the building. Draw the main scanning route with high-contrast bright red dashed lines and add small red directional arrowheads along it. Keep the main route outside the building and continuously follow the front facade, side facade, corners, and major visible outline.

Add only a small number of necessary supplementary routes for the roof, recessed regions, inclined surfaces, curved surfaces, protruding structures, or areas that are difficult to cover from the main route. Connect the main and supplementary routes into one continuous, efficient, and easy-to-understand flight trajectory.

Use semi-transparent red arcs, local coverage circles, or coverage bands to represent the 10-meter sensing range. Different line styles or a simple legend may distinguish the main route, supplementary routes, and sensing coverage. Match the building shape and image perspective, and clearly express the intention to reduce scanning levels, duplicate routes, and total flight distance.

Preserve the complete original photograph. Add only the trajectory, directional arrows, start marker, necessary sensing-range visualization, and a simple legend.

Do not repaint, deform, move, replace, or redesign the building. Do not change its materials, colors, windows, doors, roof, or structure. Do not modify the sky, ground, vehicles, people, trees, background, lighting, composition, clarity, or image style. Do not add physical drones, new buildings, new vehicles, new people, or unrelated objects.

Do not generate large numbers of parallel routes, dense scanning levels, repeated orbits, repeated scanning, meaningless backtracking, excessive turns, long detours, chaotic crossings, or random curves. Do not generate routes passing through walls or the building interior, floating paths, disconnected paths, or routes unrelated to the building outline. Do not generate only one simple line that cannot cover the main surfaces or one vertical line through the center of the building.

Do not omit the main route, necessary supplementary routes, directional arrows, or start marker. Do not allow sensing-range graphics to cover the entire building. Avoid oversized coverage circles, excessively thick lines, solid trajectory lines, oversized legends, or large text blocks.

# 候选模型概览

**BAGEL**

当前测试方式：本地 NF4

测试状态：已本地测试

官方详情：
GitHub：<https://github.com/ByteDance-Seed/Bagel>
Hugging Face：<https://huggingface.co/ByteDance-Seed/BAGEL-7B-MoT>

**Qwen-Image-Edit**

当前测试方式：ModelScope 在线体验

测试状态：已在线测试

官方详情：
GitHub：<https://github.com/QwenLM/Qwen-Image>
Hugging Face：<https://huggingface.co/Qwen/Qwen-Image-Edit>

**HunyuanImage-3-Instruct**

当前测试方式：腾讯混元官网在线体验

测试状态：已在线测试

官方详情：
GitHub：<https://github.com/Tencent-Hunyuan/HunyuanImage-3.0>

**FLUX.1 Kontext [dev]**

当前测试方式：待测试

测试状态：仅完成资料调研

官方详情：待后续补充

**Step1X-Edit**

当前测试方式：待测试

测试状态：仅完成资料调研

官方详情：待后续补充

**OmniGen2**

当前测试方式：待测试

测试状态：仅完成资料调研

官方详情：待后续补充

**FireRed-Image-Edit**

当前测试方式：待测试

测试状态：仅完成资料调研

官方详情：待后续补充

# 规则建筑结果对比

## TC-01 直译版

参考效果：

![](../../../inputs/reference_outputs/TC01_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC01_BASIC_P01_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC01_BASIC_P01_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC01_BASIC_P01_hunyuan_R01.jpeg){ width=60% }

简要说明：基础任务，Prompt 备注为“直译版”，用于观察模型是否能从简短英文要求中生成可见路线。

## TC-01 针对图像编辑模型优化版

参考效果：

![](../../../inputs/reference_outputs/TC01_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC01_BASIC_P02_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC01_BASIC_P02_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC01_BASIC_P02_hunyuan_R01.jpeg){ width=60% }

简要说明：基础任务，Prompt 备注为“针对图像编辑模型优化版”，强调原图保持、路线连续性和避免无关重绘。

## TC-02 直译版

参考效果：

![](../../../inputs/reference_outputs/TC02_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC02_OPT_P01_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC02_OPT_P01_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC02_OPT_P01_hunyuan_R01.jpeg){ width=60% }

简要说明：优化任务，Prompt 备注为“直译版”，重点观察模型是否理解 10 m 探测范围和效率要求。

## TC-02 针对图像编辑模型优化版

参考效果：

![](../../../inputs/reference_outputs/TC02_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC02_OPT_P02_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC02_OPT_P02_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC02_OPT_P02_hunyuan_R01.jpeg){ width=60% }

简要说明：优化任务，Prompt 备注为“针对图像编辑模型优化版”，强调主路线、辅助路线、覆盖范围和最少重复路径。

# 异形建筑结果对比

## TC-03 直译版

参考效果：

![](../../../inputs/reference_outputs/TC03_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC03_BASIC_P01_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC03_BASIC_P01_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC03_BASIC_P01_hunyuan_R01.jpeg){ width=60% }

简要说明：基础任务，Prompt 备注为“直译版”，用于观察模型对弧面、凹陷和突出结构的基本理解。

## TC-03 针对图像编辑模型优化版

参考效果：

![](../../../inputs/reference_outputs/TC03_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC03_BASIC_P02_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC03_BASIC_P02_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC03_BASIC_P02_hunyuan_R01.jpeg){ width=60% }

简要说明：基础任务，Prompt 备注为“针对图像编辑模型优化版”，更强调复杂轮廓贴合和避免穿墙路线。

## TC-04 直译版

参考效果：

![](../../../inputs/reference_outputs/TC04_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC04_OPT_P01_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC04_OPT_P01_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC04_OPT_P01_hunyuan_R01.jpeg){ width=60% }

简要说明：优化任务，Prompt 备注为“直译版”，用于观察模型是否能表达复杂覆盖需求。

## TC-04 针对图像编辑模型优化版

参考效果：

![](../../../inputs/reference_outputs/TC04_reference.png){ width=60% }

BAGEL（本地 NF4，约 75 秒/次）：

![](generated_assets/TC04_OPT_P02_bagel_R01.png){ width=60% }

Qwen-Image-Edit（ModelScope 在线体验，耗时待确认）：

![](../../../inputs/current_outputs/qwen-image-edit/TC04_OPT_P02_qwen_R01.png){ width=60% }

HunyuanImage-3-Instruct（腾讯混元官网在线体验，耗时待确认）：

![](../../../inputs/current_outputs/hunyuanimage3-instruct/TC04_OPT_P02_hunyuan_R01.jpeg){ width=60% }

简要说明：优化任务，Prompt 备注为“针对图像编辑模型优化版”，更强调主路线、辅助补扫和覆盖范围表达。

# 推理速度与部署条件

**BAGEL**

当前方式：本地 NF4

硬件/平台：NVIDIA RTX 4070 Ti Super 16GB

已知耗时：约 75 秒/次

说明：默认参数，详细推理参数未单独记录

**Qwen-Image-Edit**

当前方式：ModelScope 在线体验

硬件/平台：服务端硬件未公开

已知耗时：待确认

说明：默认参数，纯模型耗时未记录

**HunyuanImage-3-Instruct**

当前方式：腾讯混元官网在线体验

硬件/平台：服务端硬件未公开

已知耗时：待确认

说明：默认参数，纯模型耗时未记录

# 当前观察与主要问题

- 三种模型均已得到实际结果图，可以直接进行视觉对比。
- 当前三种模型输出格式和分辨率不一致，报告阶段按原始导出结果保留。
- 当前每次生成的详细推理参数未单独记录，但均按默认参数处理。
- 在线体验结果与本地 BAGEL 结果不构成严格公平的硬件性能比较。
- 当前输出是扫描路线示意图，不是可直接下发飞控的真实航点。

# 生成式图像编辑路线的优势与局限

## 优势

- 实现原型快，图片展示直观。
- 能够直接理解自然语言描述。
- 适合快速探索“路线应该怎样表达”。

## 局限

- 可能修改原图非航线区域。
- 输出只有像素，不具备结构化路线数据。
- 路线稳定性和可验证性不足。
- 单张图片无法恢复真实尺度、深度和障碍物约束。

# 后续技术路线建议

- 继续补充更多 Prompt 版本和更多案例图片。
- 在服务器资源可用后补测其他候选模型。
- 若下游需要结构化航点或可执行路线，应评估“视觉理解 + 路线数据 + 确定性绘制”的混合路线。

# 当前结论

- 当前三种已测试模型都能够产生可用于对比的航线示意图结果。
- 当前更适合以“参考图与模型输出图的直观差异展示”作为阶段性汇报方式。
- 是否继续采用生成式图像编辑作为主技术路线，仍需结合下游最终需要的是“示意图”还是“结构化路线数据”来判断。

# 附录

报告版本：v0.1

生成日期：2026-06-29

对应 Git 分支：main

对应 Git Commit：7e18a1f

Markdown 母版路径：docs/image_edit_model_evaluation/IMAGE_EDIT_MODEL_TECHNICAL_REPORT.md

完整实验资料、Prompt、原始输出和持续更新版本保存在当前仓库中。
