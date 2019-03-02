//
//  URLRouteMap.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

class URLRouteMap {
    static let shared = URLRouteMap()
    
    private(set) var routerTrie = URLTrie<RouteNodeType>()
    
    func register<T>(_ node: RouteNode<T>) {
        for url in node.urlPatterns {
            routerTrie.inserting(element: node, paths: URL(string: url)!.completePaths.slice)
        }
    }
    
    func matchNode(for url: URL) -> (RouteNodeType, [String: Any])? {
        return routerTrie.parse(url: url)
    }
}



