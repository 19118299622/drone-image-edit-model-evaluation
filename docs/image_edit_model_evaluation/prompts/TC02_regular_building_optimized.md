# TC-02 规则建筑带探测范围的优化航线生成

Prompt 版本：v0.1  
输入图片：`../../../inputs/source_images/regular_building_input.jpg`

## 测试用例说明

本用例使用规则建筑原始图，并加入“无人机具有全向 10 m 有效探测范围”的约束，观察模型是否能减少重复航线并表达覆盖范围。

## 中文 Prompt

请在这张建筑原始图片上添加无人机外立面扫描航线优化示意图。保持原始图片内容不变，只添加航线、方向箭头和覆盖范围标注。假设无人机具有全向 10 m 有效探测范围，请用较少的主扫描路线覆盖主要可见正立面和侧立面，避免过密、重复的扫描层。请在必要位置添加辅助路线和顶部补扫路线，用不同视觉样式区分主扫描路线、辅助路线和覆盖范围。请标出起点、终点、方向箭头、地面环绕路线、水平扫描路线和垂直连接路线。10 m 覆盖范围只作为视觉示意，不需要真实物理精度。不要修改建筑、天空、门窗、车辆、人物或背景。

## English Prompt

Add an optimized drone facade scanning route overlay to this original building photo. Keep the original image unchanged and only add routes, direction arrows, and coverage-range annotations. Assume the drone has an omnidirectional effective sensing range of 10 meters. Use fewer main scanning paths to cover the main visible front and side facades, avoiding overly dense or repeated scan layers. Add auxiliary paths and top-up scanning paths where needed, and visually distinguish the main scanning paths, auxiliary paths, and coverage range. Mark the start point, end point, direction arrows, low-level perimeter route, horizontal scanning paths, and vertical connector paths. The 10-meter range is only a visual illustration and does not need physical accuracy. Do not alter the building, sky, windows, doors, vehicles, people, or background.

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

- 单张普通图片无法恢复真实尺度、深度和物理距离。
- 10 m 只用于观察模型是否理解覆盖优化概念。

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
