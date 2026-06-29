# TC-01 规则建筑基础扫描航线生成

Prompt 版本：v0.1  
输入图片：`../../../inputs/source_images/regular_building_input.jpg`

## 测试用例说明

规则建筑具有清晰正立面、可见侧立面和转角。本测试要求模型在原图中绘制完整无人机扫描航线示意，覆盖主要可见立面。

## 中文 Prompt

请在这张建筑原始图片上添加无人机外立面扫描航线示意图。保持天空、建筑材料、门窗、车辆、人物和背景不变，只添加清晰的航线标注。请围绕主要建筑绘制多层水平扫描路线，路线应沿正立面和可见侧立面的外形分布，并在建筑转角处用垂直连接路线连接不同高度层。请标出地面附近的环绕起始路线、主扫描路线、必要的辅助路线、起点、终点和方向箭头。航线应该连续、清晰、贴合建筑轮廓，不要生成随机曲线或与建筑无关的路线。输出应是一张带航线标注的视觉示意图，不是真实可执行飞行路线。

## English Prompt

Add a drone facade scanning route overlay to this original building photo. Keep the sky, building materials, windows, doors, vehicles, people, and background unchanged, and only add clear route annotations. Draw multiple horizontal scanning paths around the main building, following the front facade and the visible side facade. Connect different height levels at the building corners with vertical connector paths. Mark a low-level perimeter starting route, main scanning paths, necessary auxiliary paths, a start point, an end point, and direction arrows. The route should be continuous, clear, and aligned with the building outline. Do not generate random curves or paths unrelated to the building. The output is a visual route illustration, not an executable flight route.

## 预期关键元素

- 地面环绕路线。
- 多层水平扫描路线。
- 垂直连接路线。
- 主扫描路线。
- 辅助路线。
- 起点与终点。
- 方向箭头。

## 已知歧义

- 单张图片无法提供真实建筑尺度和完整三维深度。
- 航线只评价视觉合理性，不评价真实飞行可行性。

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
