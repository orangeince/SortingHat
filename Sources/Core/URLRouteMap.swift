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
        for pattern in node.urlPatterns {
            if let url = URL(string: pattern) {
                routerTrie.register(element: node, with: url)
            }
        }
    }
    
    func matchNode(for url: URL) -> (RouteNodeType, [String: Any])? {
        return routerTrie.parse(url: url)
    }
    
    func register(url: URL, with handler: @escaping URLHandler) {
        handlerTrie.register(element: handler, with: url)
    }
    
    func matchHandler(for url: URL) -> (URLHandler, [String: Any])? {
        return handlerTrie.parse(url: url)
    }
}



