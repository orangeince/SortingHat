//
//  RouteNode.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public protocol RouteNodeType {
    var constructViewController: ([String: Any]) -> UIViewController? { get }
}

public struct RouteNode<T: Routable>: RouteNodeType {
    let urlPatterns: [String]
    public var constructViewController: ([String: Any]) -> UIViewController? {
        return { params in
            guard let paramters = T.Parameters.init(params: params) else { return nil }
            return T.constructViewController(params: paramters)
        }
    }
    public init() {
        urlPatterns = []
    }
}

extension RouteNode where T: URLRoutable {
    public init() { urlPatterns = [T.urlPattern] }
}

extension RouteNode where T: MultiportURLRoutable {
    public init() { urlPatterns = T.urlPatterns }
}

