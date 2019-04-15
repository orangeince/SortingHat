//
//  RouteNode.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import UIKit

/// As a route node, it should be able to construct a viewController with necessary parameters.
public protocol RouteNodeType {
    /// Construct viewController with parameters.
    ///
    /// Return nil if the parameters do not meet the requirements.
    func constructViewController(_ parameters: [String: Any]) -> UIViewController?
}

/** Bind a routable target to `RouteNode` point.
 
 A node can bind in two ways:
  - If T is URLRoutable, it is only one urlPattern to bind.
  - If T is MultiportURLRoutable, it can be bind to multiple urlPatterns.
 */
public struct RouteNode<T: Routable>: RouteNodeType {
    /// Bound urlPatterns to match this node.
    let urlPatterns: [String]
    public func constructViewController(_ parameters: [String: Any]) -> UIViewController? {
        guard let paramters = T.Parameters.init(parameters) else { return nil }
        return T.constructViewController(params: paramters)
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

