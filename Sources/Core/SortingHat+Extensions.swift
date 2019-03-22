//
//  SortingHat+Extensions.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

extension Dictionary {
    /// append new key-value which are not exist in source dict.
    func weakMerging(_ other: Dictionary) -> Dictionary {
        return merging(other, uniquingKeysWith: { a, b in a })
    }
}

extension URL {
    
    /// extract complete paths from url
    /// ```
    /// "/a/b/c" -> ["a", "b", "c"]
    ///
    /// "x://a/b/c" -> ["a", "b", "c"]
    /// ```
    var completePaths: [String] {
        var paths = pathComponents
        if paths.first == "/" {
            paths.removeFirst()
        }
        // support the url pattern like 'x://a/b/c'
        if let host = host {
            paths.insert(host, at: 0)
        }
        return paths
    }
    
    var queryItems: [String: Any] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
                return [:]
        }
        return queryItems.reduce([String: Any]()) { result, item in
            var newResult = result
            newResult[item.name] = item.value
            return newResult
        }
    }
    
}

extension Array {
    var slice: ArraySlice<Element> {
        return ArraySlice(self)
    }
}

extension ArraySlice {
    var decomposed: (Element, ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex], self.dropFirst())
    }
}

public protocol URLConvertible {
    func asURL() throws -> URL
}

public enum RouteError: Error {
    case invalidURL
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw RouteError.invalidURL }
        return url
    }
}

extension URL: URLConvertible {
    public func asURL() throws -> URL {
        return self
    }
}
