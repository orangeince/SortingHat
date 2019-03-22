//
//  RouteTargetType.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

/// Target of route node.
///
/// Example:
/// ```
/// enum StoryModule: RouteTargetType {
///     case detail
///     case list
///
///     var node: RouteNodeType {
///         switch self {
///             case .detail: return RouteNode<DetailViewController>()
///             case .list: return RouteNode<ListViewController>()
///         }
///     }
///
///     var parameters: [String: Any] {
///         switch self {
///             case .detail: return ["id": 89]
///             case .list: return [:]
///         }
///     }
/// }
/// ```
public protocol RouteTargetType {
    /// Route node for target.
    var node: RouteNodeType { get }
    /// Parameters required by route node.
    var parameters: [String: Any] { get }
}
