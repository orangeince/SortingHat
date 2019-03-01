//
//  DemoViewControllers.swift
//  SortingHat_Example
//
//  Created by 少 on 2019/3/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SortingHat

class ListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .cyan
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
