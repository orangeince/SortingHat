//
//  SortingHat.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation
import UIKit

public enum SortingHat {
    static let urlMap = URLRouteMap.shared
    
    public static func viewController(for target: RouteTargetType) -> UIViewController? {
        return target.node.constructViewController(target.parameters)
    }
    
    public static func show(target: RouteTargetType, from: UIViewController? = nil) {
        guard let viewController = viewController(for: target) else { return }
        if let from = from  {
            from.navigationController?.pushViewController(viewController, animated: true)
        } else {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController:  viewController)
        }
    }
    
    public static func register<T>(node: RouteNode<T>) {
        urlMap.register(node)
    }
    
    public static func register<T>(nodes: [RouteNode<T>]) {
        for node in nodes {
            urlMap.register(node)
        }
    }
    
    public static func register(url: URL, with handler: @escaping URLHandler) {
        urlMap.register(url: url, with: handler)
    }
    
    public static func handle(url: URL) -> Any? {
        guard let (handler, params) = urlMap.matchHandler(for: url) else {
            return nil
        }
        return handler(params)
    }
    
    public static func show(targetUrl: URL, from: UIViewController? = nil) {
        guard let (node, matchedParams) = urlMap.matchNode(for: targetUrl),
            let viewController = node.constructViewController(targetUrl.queryItems.weakMerging(matchedParams))
            else { return }
        if let from = from {
            from.navigationController?.pushViewController(viewController, animated: true)
        } else {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController:  viewController)
        }
    }
}
public typealias URLHandler = ([String: Any]) -> Any?
