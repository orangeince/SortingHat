//
//  RouteParametersTests.swift
//  SortingHat_Tests
//
//  Created by 少 on 2019/3/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import SortingHat

class RouteParametersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParametersDecodable() {
        // - Normal decodable
        struct Paramsters: ParametersDecodable {
            let title: String
            let id: Int
        }
        let json = "{\"title\": \"test\", \"id\": 89}".data(using: .utf8)!
        let decoder = JSONDecoder()
        let params = try! decoder.decode(Paramsters.self, from: json)
        XCTAssert(params.title == "test")
        XCTAssert(params.id == 89)

        // - Initialize with dict
        let p2 = Paramsters(params: ["title": "test2", "id": 100])
        XCTAssert(p2 != nil)
        XCTAssert(p2?.title == "test2")
        XCTAssert(p2?.id == 100)
        
        // - Initialize with dict, but type of id not matched, and it should be failed.
        let p3 = Paramsters(params: ["title": "test3", "id": "200"])
        XCTAssert(p3 == nil)
    }
    
    func testValueTypeDecodable() {
        struct Parameters: Decodable {
            let string: ValueType.String
            let float: ValueType.Float
            let double: ValueType.Double
            let int: ValueType.Int
            let int8: ValueType.Int8
            let int16: ValueType.Int16
            let int32: ValueType.Int32
            let int64: ValueType.Int64
            let uint: ValueType.UInt8
            let uint8: ValueType.UInt8
            let uint16: ValueType.UInt16
            let uint32: ValueType.UInt32
            let uint64: ValueType.UInt64
        }
        let decoder = JSONDecoder()
        let json = """
{
    "string": "swift",
    "float": 4.2,
    "double": 4.2,
    "int": 0,
    "int8": 8,
    "int16": 16,
    "int32": 32,
    "int64": 64,
    "uint": 0,
    "uint8": 8,
    "uint16": 16,
    "uint32": 32,
    "uint64": 64
}
""".data(using: .utf8)!
        let params = try! decoder.decode(Parameters.self, from: json)
        XCTAssert(params.string.value == "swift")
        XCTAssert(params.float.value == 4.2)
        XCTAssert(params.double.value == 4.2)
        XCTAssert(params.int.value == 0)
        XCTAssert(params.int8.value == 8)
        XCTAssert(params.int16.value == 16)
        XCTAssert(params.int32.value == 32)
        XCTAssert(params.int64.value == 64)
        XCTAssert(params.uint.value == 0)
        XCTAssert(params.uint8.value == 8)
        XCTAssert(params.uint16.value == 16)
        XCTAssert(params.uint32.value == 32)
        XCTAssert(params.uint64.value == 64)
    }
    
    func testParametersWithValueType() {
        // - Normal value type of dictionary.
        struct Parameters: ParametersDecodable {
            let string: ValueType.String
            let float: ValueType.Float
            let double: ValueType.Double
            let int: ValueType.Int
            let int8: ValueType.Int8
            let int16: ValueType.Int16
            let int32: ValueType.Int32
            let int64: ValueType.Int64
            let uint: ValueType.UInt8
            let uint8: ValueType.UInt8
            let uint16: ValueType.UInt16
            let uint32: ValueType.UInt32
            let uint64: ValueType.UInt64
        }
        let params = Parameters.init(params: [
            "string": "swift",
            "float": 4.2,
            "double": 4.2,
            "int": 0,
            "int8": 8,
            "int16": 16,
            "int32": 32,
            "int64": 64,
            "uint": 0,
            "uint8": 8,
            "uint16": 16,
            "uint32": 32,
            "uint64": 64
        ])!
        XCTAssert(params.string.value == "swift")
        XCTAssert(params.float.value == 4.2)
        XCTAssert(params.double.value == 4.2)
        XCTAssert(params.int.value == 0)
        XCTAssert(params.int8.value == 8)
        XCTAssert(params.int16.value == 16)
        XCTAssert(params.int32.value == 32)
        XCTAssert(params.int64.value == 64)
        XCTAssert(params.uint.value == 0)
        XCTAssert(params.uint8.value == 8)
        XCTAssert(params.uint16.value == 16)
        XCTAssert(params.uint32.value == 32)
        XCTAssert(params.uint64.value == 64)
        
        // - String value type of dictionary.
        let params2 =  Parameters.init(params: [
            "string": "swift",
            "float": "4.2",
            "double": "4.2",
            "int": "0",
            "int8": "8",
            "int16": "16",
            "int32": "32",
            "int64": "64",
            "uint": "0",
            "uint8": "8",
            "uint16": "16",
            "uint32": "32",
            "uint64": "64"
            ])!
        XCTAssert(params2.string.value == "swift")
        XCTAssert(params2.float.value == 4.2)
        XCTAssert(params2.double.value == 4.2)
        XCTAssert(params2.int.value == 0)
        XCTAssert(params2.int8.value == 8)
        XCTAssert(params2.int16.value == 16)
        XCTAssert(params2.int32.value == 32)
        XCTAssert(params2.int64.value == 64)
        XCTAssert(params2.uint.value == 0)
        XCTAssert(params2.uint8.value == 8)
        XCTAssert(params2.uint16.value == 16)
        XCTAssert(params2.uint32.value == 32)
        XCTAssert(params2.uint64.value == 64)
    }
}
