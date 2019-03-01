//
//  URL+SortingHat.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

extension URL {
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
