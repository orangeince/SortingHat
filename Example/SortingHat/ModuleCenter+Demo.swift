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
        return "/detail/:title"
    }
    struct Parameters: ParametersDecodable {
        let title: ValueType.String
        let id: ValueType.Int?
    }
    static func constructViewController(params: Parameters) -> UIViewController? {
        let vc = DetailViewController()
        var title = params.title.value
        if let id = params.id {
            title += "-id:\(id.value)"
        }
        vc.title = title
        return vc
    }
}

extension ListViewController: MultiportURLRoutable {
    static var urlPatterns: [String] {
        return ["/list/:title/:id", "/list/:title",]
    }
    enum Parameters: RouteParametersType {
        case list1(title: String)
        case list2(title: String, id: String)
        
        init?(_ params: [String : Any]) {
            guard let title = params["title"] as? String else { return nil }
            if let id = params["id"] as? String {
                self = .list2(title: title, id: id)
            } else {
                self = .list1(title: "LIST1")
            }
        }
    }
    static func constructViewController(params: Parameters) -> UIViewController? {
        let vc = ListViewController()
        switch params {
        case .list1(let title):
            vc.title = title
        case .list2(let title, let id):
            vc.title = title + "-" + id
        }
        return vc
    }
}
