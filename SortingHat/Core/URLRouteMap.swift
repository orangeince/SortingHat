//
//  URLRouteMap.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

class URLRouteMap {
    static let shared = URLRouteMap()
    
    private(set) var trie = URLTrie<RouteNodeType>()
    
    func register<T>(_ node: RouteNode<T>) {
        for url in node.urlPatterns {
            trie.inserting(element: node, paths: URL(string: url)!.pathComponents.slice)
        }
    }
    
    func matchNode(for url: URL) -> (RouteNodeType, [String: Any])? {
        guard let result = trie.fetch(paths: url.completePaths.slice),
            let element = result.subTrie.element else { return nil }
        return (element, result.paramsters)
    }
}



