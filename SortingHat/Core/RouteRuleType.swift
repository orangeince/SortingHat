//
//  RouteRuleType.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public protocol RouteRuleType {
    var urlPattern: String { get }
    func contruct(with: [String: Any]) -> UIViewController?
}

public protocol RouteRuleCollection {
    static var rules: [RouteRuleType] { get }
}
