//
//  URLRouteMap.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

class URLRouteMap {
    static let shared = URLRouteMap()
    
    var tire: [String: RouteNodeType] = [:]
    
    func register<T>(_ node: RouteNode<T>) {
        for url in node.urlPatterns {
            tire[url] = node
        }
    }
    
    func searchNode(for url: URL) -> RouteNodeType? {
        let path = String(url.absoluteString.prefix(10))
        guard let node = tire[path] else { return nil }
        return node
    }
}
