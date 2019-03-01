//
//  SortingHat.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public enum SortingHat {
    static let urlMap = URLRouteMap.shared
    
    public static func viewController(for target: RouteTargetType) -> UIViewController? {
        guard let rule = target.rule else { return nil }
        return rule.contruct(with: target.parameters)
    }
    
    public static func show(target: RouteTargetType, from: UIViewController? = nil) {
        guard let viewController = viewController(for: target) else { return }
        if let from = from  {
            from.navigationController?.pushViewController(viewController, animated: true)
        } else {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController:  viewController)
        }
    }
    
    public static func register(ruleCollection: RouteRuleCollection.Type) {
        for rule in ruleCollection.rules {
            urlMap.register(rule: rule)
        }
    }
    
    public static func show(targetUrl: URL, from: UIViewController? = nil) {
        guard let rule = urlMap.searchRule(for: targetUrl),
            let viewController = rule.contruct(with: targetUrl.queryItems) else { return }
        if let from = from  {
            from.navigationController?.pushViewController(viewController, animated: true)
        } else {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController:  viewController)
        }
    }
}
