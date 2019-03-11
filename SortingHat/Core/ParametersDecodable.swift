//
//  ParametersDecodable.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public protocol RouteParametersType {
    init?(params: [String: Any])
}

public protocol ParametersDecodable: RouteParametersType, Decodable {
    init?(params: [String: Any])
}

extension ParametersDecodable {
    public init?(params: [String: Any]) {
        let decoder = JSONDecoder()
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: []),
            let obj = try? decoder.decode(Self.self, from: data)
            else { return nil }
        self = obj
    }
}

public struct NoneParameters: ParametersDecodable {
    public init?(params: [String: Any]) {}
}

public struct ParameterValueType<T: Decodable>: Decodable {
    public let value: T
    
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

public enum ValueType {
    public typealias Bool = ParameterValueType<Swift.Bool>
    public typealias String = ParameterValueType<Swift.String>
    public typealias Float = ParameterValueType<Swift.Float>
    public typealias Double = ParameterValueType<Swift.Double>
    public typealias Int = ParameterValueType<Swift.Int>
    public typealias Int8 = ParameterValueType<Swift.Int8>
    public typealias Int16 = ParameterValueType<Swift.Int16>
    public typealias Int32 = ParameterValueType<Swift.Int32>
    public typealias Int64 = ParameterValueType<Swift.Int64>
    public typealias UInt = ParameterValueType<Swift.UInt>
    public typealias UInt8 = ParameterValueType<Swift.UInt8>
    public typealias UInt16 = ParameterValueType<Swift.UInt16>
    public typealias UInt32 = ParameterValueType<Swift.UInt32>
    public typealias UInt64 = ParameterValueType<Swift.UInt64>
}

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
