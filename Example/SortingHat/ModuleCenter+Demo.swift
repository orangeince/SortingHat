//
//  ModuleCenter+Demo.swift
//  SortingHat_Example
//
//  Created by 少 on 2019/3/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SortingHat

extension ModuleCenter {
    enum Demo {
        case detail(title: String)
        case list(title: String, id: String)
    }
}

extension ModuleCenter.Demo: RouteTargetType {
    var rule: RouteRuleType? {
        switch self {
        case .detail: return RouteRule<DetailViewController>()
        case .list: return RouteRule<ListViewController>()
        }
    }
    
    var parameters: [String : Any] {
        return ParametersParser.parse(enumType: self)
    }
}

extension ModuleCenter.Demo: RouteRuleCollection {
    static var rules: [RouteRuleType] {
        return [
            RouteRule<DetailViewController>(),
            RouteRule<ListViewController>()
        ]
    }
}

extension DetailViewController: URLRoutable {
    static var urlPattern: String {
        return "x://detail"
    }
    struct Paramters: ParametersDecodable {
        let title: String
    }
    static func constructViewController(params: Paramters) -> UIViewController? {
        let vc = DetailViewController()
        vc.title = params.title
        return vc
    }
}

extension ListViewController: URLRoutable {
    static var urlPattern: String {
        return "x://list//"
    }
    struct Paramters: ParametersDecodable {
        let title: String
        let id: String
    }
    static func constructViewController(params: ListViewController.Paramters) -> UIViewController? {
        let vc = ListViewController()
        vc.title = params.title
        return vc
    }
}
