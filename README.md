# SortingHat

[![CI Status](https://img.shields.io/travis/Shao/SortingHat.svg?style=flat)](https://travis-ci.org/Shao/SortingHat)
[![Version](https://img.shields.io/cocoapods/v/SortingHat.svg?style=flat)](https://cocoapods.org/pods/SortingHat)
[![License](https://img.shields.io/cocoapods/l/SortingHat.svg?style=flat)](https://cocoapods.org/pods/SortingHat)
[![Platform](https://img.shields.io/cocoapods/p/SortingHat.svg?style=flat)](https://cocoapods.org/pods/SortingHat)

`SortingHat`是一个纯Swift的路由库。提供普适的`URL`调用方案和枚举传参的内部调用方案。

## Features
- 协议声明式的路由规则定义，省心
- 安全可靠的内部调用方式，参数变更引发的错误会在编译阶段暴露，放心

## Example
1. 定义路由节点
```swift
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
```
2. 路由注册
```swift
// 注册ViewController节点
SortingHat.register(node: RouteNode<DetailViewController>())

// 注册Handler节点
SortingHat.register(url: "x://handler/:target/:action") { (params) -> String? in
    guard let target = params["target"] as? String,
        let action = params["action"] as? String
        else { return nil }
    return "target: \(target)\naction: \(action)"
}
```
3. 自动在`模块中枢`增开路由模块，以下代码可配合`Sourcery`自动生成的
```swift
extension ModuleCenter {
    enum Demo {
        case detail(title: String)
        case list(title: String, id: String)
    }
}
extension ModuleCenter.Demo: RouteNodeType {
    var node: RouteNodeType {
        switch self {
        case .detail: return RouteNode<DetailViewController>()
        case .list: return RouteNode<ListViewController>()
        }
    }
}
```
4. 业务场景使用
```swift
// URL调用方式
SortingHat.show(targetUrl: "x://detail?title=SortingHat.detail", from: self)

// 内部Target调用方式
SortingHat.show(target: ModuleCenter.Demo.list(title: "SortingHat.list", id: "BJ2019"), from: self)
```

## RoadMap
- Register URLs at module load point.
- Callback for viewcontroller.
- Auto generate extension code for submodule.

## Installation

Wait please. I'll release this library as soon as posible. >_<

## License

SortingHat is available under the MIT license. See the LICENSE file for more info.
