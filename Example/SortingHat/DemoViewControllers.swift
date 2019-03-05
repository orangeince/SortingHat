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

class DetailViewController: UIViewController, RouteMessageSenderType {
    var messageHandler: RouteMessageHandler?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        messageHandler?(.single(title ?? "emptyTitle"))
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .cyan
    }
}

