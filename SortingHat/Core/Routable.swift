//
//  Routable.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

/// 路由协议
public protocol Routable {
    /**
     Associated parametersType.
     - use inner type declaration
     - use typealias
     - note: If no need parameters, use typealias of `NoneParameters`.
     
     Example:
     ```
     // 1. inner type declaration
     struct Parameters: RouteParametersType {
        let id: Int
     }
     
     // 2. typealias
     typealias Parameters = NoneParameters
     ```
    */
    associatedtype Parameters: RouteParametersType
    
    
    /// Construct a viewcontroller with parameters.
    ///
    /// - Parameter params: matched instance of Self.Parameters
    /// - Returns: a viewController if construct success, or nil for failed.
    static func constructViewController(params: Parameters) -> UIViewController?
}

/// URL路由节点协议
/// - Note:
///     Parameters type is limit to ParametersDecodable.
///
///     This is very convenience when declaration the ParametersType and init as a Decodable.
///
/// Example:
/// ```
/// extension ListViewController: URLRoutable {
///     struct Parameters: ParametersDecodable {
///         let targetId: ValueType.Int
///     }
///
///     var urlPattern: String {
///        return "x://list/:targetId"
///     }
///
///     static func constructViewController(params: Parameters) -> UIViewController? {
///         return ListViewController(targetId: params.targetId.value)
///     }
/// }
/// ```
public protocol URLRoutable: Routable where Parameters: ParametersDecodable {
    /// URLPattern use to register.
    static var urlPattern: String { get }
}

///  多端口的URL路由节点协议
///  - 用于多个URL对应同一个ViewController的情况
///  - 使用Enum来解决参数列表也不一样的情况
///
///  Example: 示例代码如下
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
///
///    static var urlPatterns: [String] {
///        return ["x://detail", "x://detail/:title"]
///    }
///
///    static func constructViewController(params: Parameters) -> UIViewController? {
///        switch params {
///        case .customDetail(let title):
///            let vc = DetailViewController()
///            vc.title = title
///            return vc
///        case .detail:
///            let vc = DetailViewController()
///            return vc
///        }
///    }
///  }
///  ```
public protocol MultiportURLRoutable: Routable {
    static var urlPatterns: [String] { get }
}
