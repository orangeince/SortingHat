//
//  URLTrieTests.swift
//  SortingHatTests
//
//  Created by 少 on 2019/3/28.
//

import XCTest
@testable import SortingHat

class URLTrieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOperations() {
        var tire = URLTrie<Int>()
        // 1. Test registration and parse.
        tire.register(element: 1, with: URL(string: "/test/:module")!)
        let (i, params) = tire.parse(url: URL(string: "/test/story")!)!
        XCTAssert(i == 1)
        XCTAssert(params["module"] as? String == "story")
        
        // 2. Override with same url pattern.
        tire.register(element: 2, with: URL(string: "/test/:module")!)
        let (i2, params2) = tire.parse(url: URL(string: "/test/story2")!)!
        XCTAssert(i2 == 2)
        XCTAssert(params2["module"] as? String == "story2")
        
        // 3. Check url patterns.
        tire.register(element: 3, with: URL(string: "/test/3")!)
        let patterns = tire.urlPatterns
        XCTAssert(patterns.count == 2)
        XCTAssert(patterns.contains("test/3"))
        XCTAssert(patterns.contains("test/:module"))
    }


}
