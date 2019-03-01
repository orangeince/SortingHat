//
//  RouteTargetType.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public protocol RouteTargetType {
    var rule: RouteRuleType? { get }
    var parameters: [String: Any] { get }
}
