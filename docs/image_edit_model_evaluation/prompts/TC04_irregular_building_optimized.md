# TC-04 异形建筑带探测范围的优化航线生成

Prompt 版本：v0.1  
输入图片：`../../../inputs/source_images/irregular_building_input.jpg`

## 测试用例说明

本用例在异形建筑基础上加入“无人机具有全向 10 m 有效探测范围”的约束，观察模型是否能区分主航线、辅助航线、补扫航线和覆盖范围。

## 中文 Prompt

请在这张异形建筑原始图片上添加无人机扫描航线优化示意图。保持原图中的建筑、天空、门窗、车辆、人物和背景不变，只添加航线、方向箭头、图例和覆盖范围。假设无人机具有全向 10 m 有效探测范围，请用较少的主扫描路线覆盖主要可见表面，并在弧形面、倾斜面、突出结构、凹陷区域和顶部区域添加必要的辅助补扫路线。请区分主扫描路线、辅助路线、顶部补扫路线和覆盖范围，标出地面环绕路线、水平扫描路线、垂直连接路线、起点、终点和方向箭头。覆盖范围只作为视觉示意，不代表真实物理距离，也不是可执行飞控航线。

## English Prompt

Add an optimized drone scanning route overlay to this original photo of an irregular building. Keep the building, sky, windows, doors, vehicles, people, and background unchanged, and only add routes, direction arrows, a legend, and coverage-range annotations. Assume the drone has an omnidirectional effective sensing range of 10 meters. Use fewer main scanning paths to cover the main visible surfaces, and add necessary auxiliary top-up paths for curved surfaces, slanted faces, protruding structures, recessed areas, and roof or top areas. Visually distinguish the main scanning paths, auxiliary paths, top-up paths, and coverage range. Mark the low-level perimeter route, horizontal scanning paths, vertical connector paths, start point, end point, and direction arrows. The coverage range is only a visual illustration, not a real physical distance or executable flight-control route.

## 预期关键元素

- 主扫描路线。
- 辅助路线。
- 顶部补扫。
- 探测覆盖范围。
- 地面环绕路线。
- 水平扫描路线。
- 垂直连接路线。
- 起点、终点和方向箭头。

## 已知歧义

- 单张图片无法确认真实尺度、遮挡区域和顶部结构。
- 10 m 覆盖范围只评价视觉表达，不验证真实距离。

## 禁止行为

- 重绘天空。
- 改变建筑材料。
- 改变门窗。
- 改变车辆和人物。
- 改变背景建筑。
- 随机生成多余路线。
- 将水平扫描路线理解为单根竖直线。
- 生成与建筑外形无关的曲线。
- 删除原始图片内容。

## 修改记录

- v0.1：初始版本。
