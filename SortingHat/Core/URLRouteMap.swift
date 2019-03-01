//
//  URLRouteMap.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

class URLRouteMap {
    static let shared = URLRouteMap()
    
    var tire: [String: RouteRuleType] = [:]
    
    func register(rule: RouteRuleType) {
        tire[rule.urlPattern] = rule
    }
    
    func searchRule(for url: URL) -> RouteRuleType? {
        let path = String(url.absoluteString.prefix(10))
        guard let rule = tire[path] else { return nil }
        return rule
    }
}
