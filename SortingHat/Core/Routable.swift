//
//  Routable.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

/// 路由协议
public protocol Routable {
    associatedtype Paramters: RouteParametersType
    static func constructViewController(params: Paramters) -> UIViewController?
}

/// URL路由节点协议
public protocol URLRoutable: Routable where Paramters: ParametersDecodable {
    static var urlPattern: String { get }
}

///  多端口的URL路由节点协议
///  - 用于多个URL对应同一个ViewController的情况
///  - 使用Enum来解决参数列表也不一样的情况
///  eg. 示例代码如下
///  ```
///  extension DetailViewController: MultiportURLRoutable {
///    enum Parameters: RouteParametersType {
///        case customDetail(title: String)
///        case detail
///
///        init?(params: [String : Any]) {
///            if let title = params["title"] as? String {
///                self = .customDetail(title: title)
///            } else {
///                self = .detail
///            }
///        }
///    }
///    static var urlPatterns: [String] {
///        return ["x://detail", "x://DETAIL"]
///    }
///    static func constructViewController(params: Parameters) -> UIViewController? {
///        switch params {
///        case .customDetail(let title):
///            let vc = UIViewController()
///            vc.title = title
///            return vc
///        case .detail:
///            let vc = UIViewController()
///            vc.title = "none"
///            return vc
///        }
///    }
///  }
///  ```
public protocol MultiportURLRoutable: Routable {
    static var urlPatterns: [String] { get }
}

