//
//  ViewController.swift
//  SortingHat
//
//  Created by Shao on 03/01/2019.
//  Copyright (c) 2019 Shao. All rights reserved.
//

import UIKit
import SortingHat

class ViewController: UITableViewController {
    struct CellAction {
        let title: String
        let action: (UIViewController)->()
    }
    
    lazy var actions: [CellAction] = generateDemoData()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = actions[indexPath.row].title
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        actions[indexPath.row].action(self)
    }
}

extension ViewController {
    func generateDemoData() -> [CellAction] {
        return [
            CellAction(title: "Internal invoke", action: { vc in
                SortingHat.show(targetUrl: "x://detail/SortingHat?id=89", from: vc)
                //SortingHat.show(target: ModuleCenter.Demo.detail(title: "Sorting.detail"), from: vc)
            }),
            CellAction(title: "URL invoke with one parameter", action: { vc in
                SortingHat.show(targetUrl: "x://list/SortingHat.list1", from: vc)
            }),
            CellAction(title: "URL invoke with two parameters", action: { vc in
                SortingHat.show(targetUrl: "x://list/SortingHat.list2/100", from: vc)
            }),
            CellAction(title: "URL handler", action: { vc in
                let actionUrl = "x://handler/storyTarget/commentAction?content=Hello,SortingHat"
                let actionResult = (SortingHat.handle(url: actionUrl) as? String) ?? "Action handler parse error!"
                let alert = UIAlertController(title: "URLHandler", message: actionResult, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                vc.present(alert, animated: true, completion: nil)
            }),
        ]
    }
}

