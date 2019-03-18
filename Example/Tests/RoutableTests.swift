//
//  RoutableTests.swift
//  SortingHat_Tests
//
//  Created by 少 on 2019/3/7.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import SortingHat

class RoutableTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLRoutable() {
        // Prepare data.
        class TestViewController: UIViewController, URLRoutable {
            var id: Int?
            static var urlPattern: String {
                return "/test/:title"
            }
            struct Parameters: ParametersDecodable {
                let title: ValueType.String
                let id: ValueType.Int?
            }
            static func constructViewController(params: Parameters) -> UIViewController? {
                let vc = TestViewController()
                vc.title = params.title.value
                vc.id = params.id?.value
                return vc
            }
        }

        // Not matched url.
        XCTAssert(SortingHat.viewController(for: "/test") == nil)
        
        // Normal matched url and parameters.
        SortingHat.register(node: RouteNode<TestViewController>())
        let vc = SortingHat.viewController(for: "/test/normal?id=89") as? TestViewController
        XCTAssert(vc != nil)
        XCTAssert(vc!.title == "normal")
        XCTAssert(vc!.id == 89)
        
        // Matched url and optional parameter.
        let vc2 = SortingHat.viewController(for: "/test/withoutId") as? TestViewController
        XCTAssert(vc2 != nil)
        XCTAssert(vc2!.id == nil)
    }
    
    func testMultiportURLRoutable() {
        // Prepare data.
        class TestViewController2: UIViewController, MultiportURLRoutable {
            enum Parameters: RouteParametersType {
                case customDetail(title: String)
                case detail
            
                init?(_ params: [String : Any]) {
                    if let title = params["title"] as? String {
                        self = .customDetail(title: title)
                    } else {
                        self = .detail
                    }
                }
            }
            
        static var urlPatterns: [String] {
            return ["x://test2/:title", "x://test2"]
        }
            
        static func constructViewController(params: Parameters) -> UIViewController? {
            switch params {
                case .customDetail(let title):
                    let vc = TestViewController2()
                    vc.title = title
                    return vc
                case .detail:
                    return TestViewController2()
                }
            }
        }
        
        SortingHat.register(node: RouteNode<TestViewController2>())
        
        // Not matched url.
        XCTAssert(SortingHat.viewController(for: "x://test") == nil)
        
        // Matched first case of parameters.
        let vc1 = SortingHat.viewController(for: "x://test2/case1") as? TestViewController2
        XCTAssert(vc1 != nil)
        XCTAssert(vc1!.title == "case1")
        
        // Matched second case of parameters.
        let vc2 = SortingHat.viewController(for: "x://test2") as? TestViewController2
        XCTAssert(vc2 != nil)
        XCTAssert(vc2!.title == nil)
    }

}
