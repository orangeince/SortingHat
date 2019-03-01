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

public struct NoneParamters: ParametersDecodable {
    public init?(params: [String: Any]) {}
}
