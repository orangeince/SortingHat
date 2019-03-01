//
//  Routable.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public protocol Routable {
    associatedtype Paramters: ParametersDecodable
    static func constructViewController(params: Paramters) -> UIViewController?
}

public protocol URLRoutable: Routable {
    static var urlPattern: String { get }
}
