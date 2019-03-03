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
    private(set) var handlerTrie = URLTrie<URLHandler>()
    
    func register<T>(_ node: RouteNode<T>) {
        for url in node.urlPatterns {
            routerTrie.insert(element: node, paths: URL(string: url)!.completePaths.slice)
        }
    }
    
    func matchNode(for url: URL) -> (RouteNodeType, [String: Any])? {
        return routerTrie.parse(url: url)
    }
    
    func register(url: URL, with handler: @escaping URLHandler) {
        handlerTrie.insert(element: handler, paths: url.completePaths.slice)
    }
    
    func matchHandler(for url: URL) -> (URLHandler, [String: Any])? {
        return handlerTrie.parse(url: url)
    }
}



