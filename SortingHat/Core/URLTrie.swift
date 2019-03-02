//
//  URLTrie.swift
//  SortingHat
//
//  Created by 少 on 2019/3/2.
//

import Foundation

struct URLTrie<Element> {
    var element: Element?
    var children: [String: URLTrie<Element>]

    mutating func inserting(element: Element, paths: ArraySlice<String>) {
        guard let (head, tail) = paths.decomposed else {
            return self.element = element
        }
        if children[head] != nil {
            children[head]?.inserting(element: element, paths: tail)
        } else {
            children[head] = URLTrie(element: element, paths: tail)
        }
    }
    
    typealias FetchResult = (subTrie: URLTrie<Element>, paramsters: [String: Any])
    /// 根据路径遍历整棵树，找到带有节点的子树并拼接参数
    func fetch(paths: ArraySlice<String>) -> FetchResult? {
        guard let (head, tail) = paths.decomposed else { return (self, [:]) }
        // 先找Key严格匹配的子树，后找有PlaceHolder的子树
        if let remainder = children[head], let result = remainder.fetch(paths: tail) {
            return result
        } else  {
            // 在遍历有PlaceHolder子树的时候把PlaceHolder和Key值一并放入参数列表中
            let placeholderChildren = children.filter({$0.key.first == ":"})
            guard !placeholderChildren.isEmpty else { return nil }
            for (key, value) in placeholderChildren {
                if let result = value.fetch(paths: tail) {
                    var params = result.paramsters
                    let newKey = String(key.dropFirst())
                    params.updateValue(head, forKey: newKey)
                    return (result.subTrie, params)
                }
            }
            return nil
        }
    }
}

extension URLTrie {
    init() {
        element = nil
        children = [:]
    }
    
    init(element: Element, paths: ArraySlice<String>) {
        if let (head, tail) = paths.decomposed {
            let children = [head: URLTrie(element: element, paths: tail)]
            self = URLTrie(element: nil, children: children)
        } else {
            self = URLTrie(element: element, children: [:])
        }
    }
}

extension URLTrie {
    /// use for debug to check trie.
    var urlPatterns: [String] {
        var result: [String] = element == nil ? [] : [""]
        for (k, v) in children {
            result += v.urlPatterns.map{ k + "/" + $0 }
        }
        return result
    }
}
