//
//  RouteMessageTests.swift
//  SortingHat_Tests
//
//  Created by 少 on 2019/3/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import SortingHat

class RouteMessageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMessageHandler() {
        // Prepare data
        class TestViewController: UIViewController, URLRoutable, RouteMessageSenderType {
            var id: Int?
            static var urlPattern: String { return "/test/:title" }
            struct Parameters: ParametersDecodable {
                let title: ValueType.String
                let id: ValueType.Int?
            }
            static func constructViewController(params: TestViewController.Parameters) -> UIViewController? {
                let vc = TestViewController()
                vc.title = params.title.value
                vc.id = params.id?.value
                return vc
            }
            var messageHandler: RouteMessageHandler?
            func sendMessageAboutTitle() -> Bool {
                guard let handler = messageHandler else { return false}
                handler(title)
                return true
            }
            func sendMessageAboutId() -> Bool {
                guard let handler = messageHandler else { return false}
                handler(id)
                return true
            }
        }
        SortingHat.register(node: RouteNode<TestViewController>())
        
        // Test
        let vc = SortingHat.viewController(for: "/test/detail?id=89") as? TestViewController
        XCTAssert(vc != nil)
        XCTAssert(vc!.id != nil)
        
        // Handler is nil
        XCTAssert(vc?.sendMessageAboutTitle() == false)
        XCTAssert(vc?.sendMessageAboutId() == false)
        
        // Send a message of string type.
        vc?.messageHandler = { message in
            XCTAssert(message is String?)
            XCTAssert((message as? String) == "detail")
        }
        XCTAssert(vc?.sendMessageAboutTitle() == true)
        
        // Send a message of int type.
        vc?.messageHandler = { message in
            XCTAssert(message is Int?)
            XCTAssert((message as? Int) == 89)
        }
        XCTAssert(vc?.sendMessageAboutId() == true)
    }

}
