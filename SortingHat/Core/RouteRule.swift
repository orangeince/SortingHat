//
//  RouteRule.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public struct RouteRule<T: URLRoutable>: RouteRuleType {
    public init() {}
    public var urlPattern: String {
        return T.urlPattern
    }
    public func contruct(with params: [String : Any]) -> UIViewController? {
        guard let paramters = T.Paramters.init(params: params) else { return nil }
        return T.constructViewController(params: paramters)
    }
}

