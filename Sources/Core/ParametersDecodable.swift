//
//  ParametersDecodable.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

/// Parameters to construct a route target.
public protocol RouteParametersType {
    init?(_ params: [String: Any])
}

/** Decodable parameters.
 
 It takes advantage of the convenience of the system default implementation.
 It will convert the dictionary to json, and then decode from json data.
 ```
 struct Parameters: ParametersDecodable {
    let id: Int
    let name: String
 }
 let params = Parameters(["id": 89, "name": "SortingHat"])
 print(params.id) // 89
 print(params.name) // SortingHat
 ```
 */
public protocol ParametersDecodable: RouteParametersType, Decodable {
    init?(_ params: [String: Any])
}

extension ParametersDecodable {
    /// Initialized with a dictionary.
    ///
    /// This method will convert the dictionary to json, and then decode from json data.
    public init?(_ params: [String: Any]) {
        let decoder = JSONDecoder()
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: []),
            let obj = try? decoder.decode(Self.self, from: data)
            else { return nil }
        self = obj
    }
}

/// No necessary parameters.
public struct NoneParameters: ParametersDecodable {
    public init?(_ params: [String: Any]) {}
}

/** Value type of parameter.This is just a wapper like Box<Int>.
 
 In order to solve the problem that the parameter type parsed from the URL is always String.
 
 If T is confirmed Decodable, this is confirm Decodable too.
 
 ```
 let x = ParameterValue<Int>(10)
 print(x.value) // 10
 ```
 
 */
public struct ParameterValue<T> {
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}

extension ParameterValue: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self),
            let T = T.self as? StringConvertible.Type,
            let value = T.init(str) {
            self.value = value as! T
        } else {
            value = try container.decode(T.self)
        }
    }
}

/// A collection of default value types.Just like a namespace
public enum ValueType {
    /// Type of value is String
    public typealias String = ParameterValue<Swift.String>
    /// Type of value is Bool, and can be decode from a string type value.
    public typealias Bool = ParameterValue<Swift.Bool>
    /// Type of value is Float, and can be decode from a string type value.
    public typealias Float = ParameterValue<Swift.Float>
    /// Type of value is Double, and can be decode from a string type value.
    public typealias Double = ParameterValue<Swift.Double>
    /// Type of value is Int, and can be decode from a string type value.
    public typealias Int = ParameterValue<Swift.Int>
    /// Type of value is Int8, and can be decode from a string type value.
    public typealias Int8 = ParameterValue<Swift.Int8>
    /// Type of value is Int16, and can be decode from a string type value.
    public typealias Int16 = ParameterValue<Swift.Int16>
    /// Type of value is Int32, and can be decode from a string type value.
    public typealias Int32 = ParameterValue<Swift.Int32>
    /// Type of value is Int64, and can be decode from a string type value.
    public typealias Int64 = ParameterValue<Swift.Int64>
    /// Type of value is UInt, and can be decode from a string type value.
    public typealias UInt = ParameterValue<Swift.UInt>
    /// Type of value is UInt8, and can be decode from a string type value.
    public typealias UInt8 = ParameterValue<Swift.UInt8>
    /// Type of value is UInt16, and can be decode from a string type value.
    public typealias UInt16 = ParameterValue<Swift.UInt16>
    /// Type of value is UInt32, and can be decode from a string type value.
    public typealias UInt32 = ParameterValue<Swift.UInt32>
    /// Type of value is UInt64, and can be decode from a string type value.
    public typealias UInt64 = ParameterValue<Swift.UInt64>
}

/// The value can be convert from a string. Like Int.
protocol StringConvertible {
    init?(_ description: String)
}
extension Bool: StringConvertible {}
extension String: StringConvertible {}
extension Float: StringConvertible {}
extension Double: StringConvertible {}
extension Int: StringConvertible {}
extension Int8: StringConvertible {}
extension Int16: StringConvertible {}
extension Int32: StringConvertible {}
extension Int64: StringConvertible {}
extension UInt: StringConvertible {}
extension UInt8: StringConvertible {}
extension UInt16: StringConvertible {}
extension UInt32: StringConvertible {}
extension UInt64: StringConvertible {}
