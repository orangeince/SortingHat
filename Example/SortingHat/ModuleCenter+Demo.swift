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
    var node: RouteNodeType {
        switch self {
        case .detail: return RouteNode<DetailViewController>()
        case .list: return RouteNode<ListViewController>()
        }
    }
    
    var parameters: [String : Any] {
        return ParametersParser.parse(enumType: self)
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

extension ListViewController: MultiportURLRoutable {
    static var urlPatterns: [String] {
        return ["x://list1/", "x://list2/"]
    }
    enum Paramters: RouteParametersType {
        case list1(title: String)
        case list2(title: String)
        
        init?(params: [String : Any]) {
            guard let title = params["title"] as? String else { return nil }
            if title.contains("list1") {
                self = .list1(title: "LIST1")
            } else {
                self = .list2(title: title)
            }
        }
    }
    static func constructViewController(params: Paramters) -> UIViewController? {
        let vc = ListViewController()
        switch params {
        case .list1(let title):
            vc.title = title
        case .list2(let title):
            vc.title = title
        }
        return vc
    }
}
