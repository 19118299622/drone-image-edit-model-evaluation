# 优化任务共享 Prompt

本文件用于记录优化任务共享 Prompt，供 `TC-02` 和 `TC-04` 共用。你不需要关心 Markdown 语法，只需要把 `待填写` 替换成你的内容，或者复制一个完整的“Prompt 槽位”继续往下加。

统一 Prompt 来源：`../TEST_PROTOCOL.md`
统一 Prompt 版本：`master-v0.1`
适用测试用例：`TC-02`、`TC-04`

## 适用范围

- `TC-02`：规则建筑带探测范围的优化航线生成。
- `TC-04`：异形建筑带探测范围的优化航线生成。

## Prompt 槽位 P01

- prompt_id：`OPT_P01`
- prompt_version：`p01-v0.1`
- 状态：`已填写`
- 是否推荐：`否`
- 备注：`直译版`

中文阅读版：

`假设无人机的探测范围为全向 10 米，请给出能够最快完成整个建筑物扫描的飞行轨迹，并将轨迹绘制在输入图片中，最终输出完整图片。`

英文实际输入版：

`Assume that the drone has an omnidirectional sensing range of 10 meters. Generate a flight trajectory that can complete the scan of the entire building as quickly as possible, draw the trajectory on the input image, and output the complete image.`

相对统一 Prompt 的附加要求：

`无额外补充，作为优化任务的基础直译版测试。`

预期观察点：

`观察模型是否能理解 10 米探测范围、扫描效率和覆盖优化。`

结果图片文件名建议：

- TC-02 BAGEL：`TC02_OPT_P01_bagel_R01.png`
- TC-02 Qwen：`TC02_OPT_P01_qwen_R01.png`
- TC-04 BAGEL：`TC04_OPT_P01_bagel_R01.png`
- TC-04 Qwen：`TC04_OPT_P01_qwen_R01.png`

## Prompt 槽位 P02

- prompt_id：`OPT_P02`
- prompt_version：`p02-v0.1`
- 状态：`已填写`
- 是否推荐：`是`
- 备注：`针对图像编辑模型优化版`

中文阅读版：

`在原始照片上叠加一套紧凑、连续、清晰且视觉上合理的无人机优化扫描航线。唯一的扫描目标是画面中的白色主体建筑。

假设无人机传感器能够在所有方向有效探测距离航线 10 米以内的建筑表面。使用尽可能少的主扫描路线覆盖较大的连续立面和主要可见表面，并减少重复扫描、回头、交叉和无效绕行。当一条航线的 10 米探测范围能够覆盖相邻区域时，不再增加重复的平行路线。

在建筑附近的地面区域设置一个绿色圆形起点。使用高对比度红色虚线绘制主扫描路线，并沿路线添加小型红色方向箭头。主路线应位于建筑外侧，并沿正立面、侧立面、转角和主要轮廓连续延伸。

对于屋顶、凹陷区域、倾斜表面、弧面、突出结构或主路线难以覆盖的位置，仅添加少量必要的辅助补扫路径。主路线和辅助路线应连接成一条连续、高效且容易理解的飞行轨迹。

可以使用半透明红色圆弧、局部覆盖圆或覆盖带表达 10 米探测范围。可以通过不同线型或简洁图例区分主路线、辅助路线和探测覆盖范围。航线应符合建筑外形和图片透视，并明显表现出减少扫描层数、重复路径和总飞行距离的优化意图。

完整保留原始照片。只添加航线、方向箭头、起点、必要的覆盖范围和简洁图例。

不要重绘、变形、移动、替换或重新设计建筑。不要改变建筑材质、颜色、门窗、屋顶和结构。不要修改天空、地面、车辆、人物、树木、背景、光照、构图、清晰度或图片风格。不要添加实体无人机、新建筑、新车辆、新人物或其他无关物体。

不要生成大量平行航线、密集扫描层、重复环绕、重复扫描、无意义回头、过多转弯、长距离绕行、杂乱交叉或随机曲线。不要生成穿墙路线、穿过建筑内部的路线、悬空路线、断裂路线或与建筑轮廓无关的路线。不要只生成一根无法覆盖主要表面的简单直线或一根中央竖线。

不要遗漏主路线、必要补扫路线、方向箭头或起点。不要让覆盖范围遮挡整栋建筑。不要使用过大的覆盖圆、过粗的线条、实线航线、巨大图例或大段文字。`

英文实际输入版：

`Overlay a compact, continuous, clear, and visually plausible optimized drone scanning trajectory on the original photograph. The only scanning target is the main white building in the image.

Assume that the drone sensor can effectively observe building surfaces within 10 meters in every direction from the flight path. Use as few main scanning routes as reasonably possible to cover large continuous facades and the main visible surfaces, while reducing repeated scanning, backtracking, crossings, and unnecessary detours. When the 10-meter sensing range of one route can cover an adjacent area, avoid adding a duplicate parallel route.

Place one green circular start marker on the ground near the building. Draw the main scanning route with high-contrast bright red dashed lines and add small red directional arrowheads along it. Keep the main route outside the building and continuously follow the front facade, side facade, corners, and major visible outline.

Add only a small number of necessary supplementary routes for the roof, recessed regions, inclined surfaces, curved surfaces, protruding structures, or areas that are difficult to cover from the main route. Connect the main and supplementary routes into one continuous, efficient, and easy-to-understand flight trajectory.

Use semi-transparent red arcs, local coverage circles, or coverage bands to represent the 10-meter sensing range. Different line styles or a simple legend may distinguish the main route, supplementary routes, and sensing coverage. Match the building shape and image perspective, and clearly express the intention to reduce scanning levels, duplicate routes, and total flight distance.

Preserve the complete original photograph. Add only the trajectory, directional arrows, start marker, necessary sensing-range visualization, and a simple legend.

Do not repaint, deform, move, replace, or redesign the building. Do not change its materials, colors, windows, doors, roof, or structure. Do not modify the sky, ground, vehicles, people, trees, background, lighting, composition, clarity, or image style. Do not add physical drones, new buildings, new vehicles, new people, or unrelated objects.

Do not generate large numbers of parallel routes, dense scanning levels, repeated orbits, repeated scanning, meaningless backtracking, excessive turns, long detours, chaotic crossings, or random curves. Do not generate routes passing through walls or the building interior, floating paths, disconnected paths, or routes unrelated to the building outline. Do not generate only one simple line that cannot cover the main surfaces or one vertical line through the center of the building.

Do not omit the main route, necessary supplementary routes, directional arrows, or start marker. Do not allow sensing-range graphics to cover the entire building. Avoid oversized coverage circles, excessively thick lines, solid trajectory lines, oversized legends, or large text blocks.`

相对统一 Prompt 的附加要求：

`强调最少主路线、覆盖范围可视化、辅助补扫、避免重复和平行扫描层。`

预期观察点：

`观察模型是否能在保留原图的同时表达优化后的主路线、补扫路线与覆盖范围。`

结果图片文件名建议：

- TC-02 BAGEL：`TC02_OPT_P02_bagel_R01.png`
- TC-02 Qwen：`TC02_OPT_P02_qwen_R01.png`
- TC-04 BAGEL：`TC04_OPT_P02_bagel_R01.png`
- TC-04 Qwen：`TC04_OPT_P02_qwen_R01.png`

## Prompt 槽位 P03

- prompt_id：`OPT_P03`
- prompt_version：`p03-v0.1`
- 状态：`待填写`
- 是否推荐：`否`
- 备注：`待填写`

中文阅读版：

`待填写`

英文实际输入版：

`待填写`

相对统一 Prompt 的附加要求：

`待填写`

预期观察点：

`待填写`

结果图片文件名建议：

- TC-02 BAGEL：`TC02_OPT_P03_bagel_R01.png`
- TC-02 Qwen：`TC02_OPT_P03_qwen_R01.png`
- TC-04 BAGEL：`TC04_OPT_P03_bagel_R01.png`
- TC-04 Qwen：`TC04_OPT_P03_qwen_R01.png`

## 修改记录

- 2026-06-29：建立优化任务共享 Prompt 文件，供 TC-02 与 TC-04 共用。
