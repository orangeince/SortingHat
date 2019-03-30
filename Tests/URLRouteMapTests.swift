//
//  URLRouteMapTests.swift
//  SortingHatTests
//
//  Created by 少 on 2019/3/30.
//

import XCTest
@testable import SortingHat

class URLRouteMapTests: XCTestCase {
    class TestNode: URLRoutable {
        static var urlPattern: String {
            return "/test/node"
        }
        
        static func constructViewController(params: NoneParameters) -> UIViewController? {
            return nil
        }
        
        typealias Parameters = NoneParameters
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOperations() {
        let map = URLRouteMap()
        // 1. Registration
        map.register(RouteNode<TestNode>())
        map.register(url: URL(string: "/test/handler")!) { (params) -> String? in
            if let message = params["msg"] as? String {
                return message
            } else {
                return nil
            }
        }
        
        // 2. Match
        let nodeInfo = map.matchNode(for: URL(string: "/test/node")!)
        XCTAssert(nodeInfo != nil)
        XCTAssert(nodeInfo!.1.isEmpty)
        XCTAssert(nodeInfo!.0 is RouteNode<TestNode>)
        
        let handler = map.matchHandler(for: URL(string: "/test/handler")!)
        XCTAssert(handler != nil)
        XCTAssert(handler!.1.isEmpty)
        let (closure, params) = handler!
        XCTAssert(closure(params) == nil)
        XCTAssert(closure(["msg": "test"]) as? String == "test")
    }
    
    func testSameURL() {
        let map = URLRouteMap()
        map.register(RouteNode<TestNode>())
        map.register(url: URL(string: TestNode.urlPattern)!) { (params) -> String in
            return "success"
        }
        
        XCTAssert(map.matchNode(for: URL(string: TestNode.urlPattern)!) != nil)
        let (handler, params) = map.matchHandler(for: URL(string: TestNode.urlPattern)!)!
        XCTAssert(handler(params) as? String == "success")
    }

}
