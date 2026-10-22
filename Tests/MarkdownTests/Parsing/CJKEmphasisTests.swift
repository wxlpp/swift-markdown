import XCTest
@testable import Markdown

final class CJKEmphasisTests: XCTestCase {
    func testOptInRetainsOriginalSourceRange() throws {
        let source = "中**“文”**后"
        let strict = Document(parsing: source, options: [.disableSmartOpts])
        XCTAssertFalse(strict.child(at: 0)!.children.contains { $0 is Strong })
        let document = Document(parsing: source, options: [.disableSmartOpts, .cjkFriendlyEmphasis])
        let strong = try XCTUnwrap(document.child(at: 0)?.child(at: 1) as? Strong)
        XCTAssertEqual(strong.plainText, "“文”")
        XCTAssertEqual(strong.range?.lowerBound.column, 4)
        XCTAssertEqual(strong.range?.upperBound.column, 17)
        XCTAssertEqual((document.child(at: 0)?.child(at: 0) as? Text)?.string, "中")
    }

    func testCodeAndEscapesRemainLiteral() {
        let document = Document(parsing: "`中文**“原文”**`", options: .cjkFriendlyEmphasis)
        XCTAssertEqual((document.child(at: 0)?.child(at: 0) as? InlineCode)?.code, "中文**“原文”**")
        let escaped = Document(parsing: #"中文\*\*“原文”\*\*"#, options: .cjkFriendlyEmphasis)
        XCTAssertFalse(escaped.child(at: 0)!.children.contains { $0 is Strong })
    }
}
