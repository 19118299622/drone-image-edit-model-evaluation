# TC-03 异形建筑基础扫描航线生成

Prompt 版本：v0.1  
输入图片：`../../../inputs/source_images/irregular_building_input.jpg`

## 测试用例说明

异形建筑包含弧形、倾斜、突出或凹陷结构。本测试观察模型是否能根据复杂轮廓生成扫描航线示意。

## 中文 Prompt

请在这张异形建筑原始图片上添加无人机扫描航线示意图。保持天空、建筑表面、门窗、车辆、人物和背景不变，只添加清晰的航线标注。请识别主要异形建筑轮廓，沿弧形表面、倾斜面、突出结构和凹陷结构绘制低层、中层和高层扫描路线。路线应尽量贴合可见建筑外形，不要穿过建筑内部。请绘制主扫描路线、必要辅助路线、垂直连接路线、地面环绕路线、起点、终点、方向箭头和简洁图例。输出是无人机扫描路线的视觉示意，不是真实三维飞行航点。

## English Prompt

Add a drone scanning route overlay to this original photo of an irregular building. Keep the sky, building surfaces, windows, doors, vehicles, people, and background unchanged, and only add clear route annotations. Identify the main irregular building outline and draw low-level, mid-level, and high-level scanning paths along curved surfaces, slanted faces, protruding structures, and recessed structures. The route should follow the visible building shape as much as possible and should not pass through the building interior. Draw the main scanning paths, necessary auxiliary paths, vertical connector paths, a low-level perimeter route, a start point, an end point, direction arrows, and a concise legend. The output is a visual drone scanning route illustration, not real 3D flight waypoints.

## 预期关键元素

- 低层、中层和高层路线。
- 跟随弧面和斜面的路线。
- 主扫描路线。
- 辅助路线。
- 垂直连接路线。
- 地面环绕路线。
- 起点、终点、方向箭头和图例。

## 已知歧义

- 图片无法恢复完整三维结构。
- 异形结构的遮挡面无法从单图直接确认。

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
