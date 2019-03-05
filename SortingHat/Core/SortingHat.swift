//
//  SortingHat.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation
import UIKit

public typealias URLHandler = ([String: Any]) -> Any?

public enum SortingHat {
    static let urlMap = URLRouteMap.shared
    
    public static func viewController(for target: RouteTargetType) -> UIViewController? {
        return target.node.constructViewController(target.parameters)
    }
    
    public static func show(target: RouteTargetType, from: UIViewController? = nil, messageHandler: RouteMessageHandler? = nil) {
        guard let viewController = viewController(for: target) else { return }
        if let handler = messageHandler,
            var sender = viewController as? RouteMessageSenderType {
            sender.messageHandler = handler
        }
        show(viewController, from: from)
    }
    
    public static func show(targetUrl: URLConvertible, from: UIViewController? = nil, messageHandler: RouteMessageHandler? = nil) {
        guard let url = try? targetUrl.asURL(),
            let (node, matchedParams) = urlMap.matchNode(for: url),
            let viewController = node.constructViewController(url.queryItems.weakMerging(matchedParams))
            else { return }
        if let handler = messageHandler,
            var sender = viewController as? RouteMessageSenderType {
            sender.messageHandler = handler
        }
        show(viewController, from: from)
    }
    
    private static func show(_ viewController: UIViewController, from: UIViewController?) {
        if let from = from {
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
    
    @discardableResult
    public static func register(url: URLConvertible, with handler: @escaping URLHandler) -> Bool {
        guard let url = try? url.asURL() else { return false }
        urlMap.register(url: url, with: handler)
        return true
    }
    
    public static func canHandle(url: URLConvertible) -> Bool {
        guard let url = try? url.asURL() else { return false }
        return urlMap.matchHandler(for: url) != nil
    }
    
    @discardableResult
    public static func handle(url: URLConvertible) -> Any? {
        guard let url = try? url.asURL(),
            let (handler, params) = urlMap.matchHandler(for: url) else {
            return nil
        }
        return handler(params.weakMerging(url.queryItems))
    }
}
