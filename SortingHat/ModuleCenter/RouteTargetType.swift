//
//  RouteTargetType.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public protocol RouteTargetType {
    var node: RouteNodeType { get }
    var parameters: [String: Any] { get }
}
