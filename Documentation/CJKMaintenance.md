# CJK 强调桥接维护

基线：swiftlang/swift-markdown 0.8.0，3c6f9523da3a1ec2fd829673e472d95b8097a3b8。计划维护版本 0.8.1，尚未发布。

新增 `.cjkFriendlyEmphasis` 解析选项，默认关闭，映射 cmark 的同名 opt-in。原始文本和源码范围不经替换。固定依赖 wxlpp/swift-cmark 0.9.1；与官方 swift-markdown / swift-cmark 互斥，不支持混合来源的相同 identity。

上游 API、编辑树和渲染实现保持原样。后续上游安全更新必须保留这一小块显式映射并跑完整测试；上游原生支持后，通过明确迁移版本退回官方 URL，禁止覆盖 tag。

验证：测试先证明选项尚未传到底层时 Strong 缺失；接通后完整 XCTest 301 项通过（/tmp/swift-cjk-green.log），包括原文 source range、严格模式及代码/转义。日志末尾额外的 Swift Testing 0 项不代表没有执行测试，实际 XCTest 数量为 301。

依赖验证目前使用临时 bare Git mirror 中的 cmark 0.9.1 tag（102ac97c）。这验证了精确版本解析，但不表示公共远端已发布；下游发布前仍需干净缓存完整图验证。
