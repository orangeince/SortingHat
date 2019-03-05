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
        let name: String
        let code: String
        let action: (UIViewController)->()
    }
    struct Section {
        let title: String
        let actions: [CellAction]
    }
    
    lazy var sections: [Section] = generateDemoSections()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForDemo()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].actions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].actions[indexPath.row].name
        cell.detailTextLabel?.text = sections[indexPath.section].actions[indexPath.row].code
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].actions[indexPath.row].action(self)
    }
}

extension ViewController {
    func prepareForDemo() {
        SortingHat.register(node: RouteNode<DetailViewController>())
        SortingHat.register(node: RouteNode<ListViewController>())
        SortingHat.register(url: "/handler/:target/:action") { (params) -> String? in
            guard let target = params["target"] as? String,
                let action = params["action"] as? String,
                let content = params["content"] as? String
                else { return nil }
            return "target: \(target)\naction: \(action)\ncontent: \(content)"
        }
    }
    
    func generateDemoSections() -> [Section] {
        return [
            Section(title: "Internal invoke",
                    actions: [
                        CellAction(name: "Target of [Detail] with parameters",
                                   code: "ModuleCenter.Demo.detail(title: \"DETAIL\")") { vc in
                            SortingHat.show(target: ModuleCenter.Demo.detail(title: "DETAIL"), from: vc)
                        },
                        CellAction(name: "Target of [Detail] and return result",
                                   code: "") { vc in
                            SortingHat.show(target: ModuleCenter.Demo.detail(title: "DETAIL"), from: vc) { result in
                                guard case let .single(any) = result,
                                    let title = any as? String else { return }
                                        print(title)
                            }
                        }]),
            
            Section(title: "URL invoke",
                    actions:[
                        CellAction(name: "Route to [Detail] with title and id",
                                   code: "/detail/DETAIL?id=89") { vc in
                            SortingHat.show(targetUrl: "/detail/DETAIL?id=89", from: vc)
                        },
                        CellAction(name: "Route to [List] with one parameter",
                                   code: "/list/LIST1") { vc in
                            SortingHat.show(targetUrl: "/list/LIST1", from: vc)
                        },
                        CellAction(name: "Route to [List] with two parameters",
                                   code: "/list/LIST2/100") { vc in
                            SortingHat.show(targetUrl: "/list/LIST2/100", from: vc)
                        }]),
            
            Section(title: "URL handler",
                    actions: [
                        CellAction(name: "Parse url to get handler return value",
                                   code: "/handler/story/comment?content=Hello,SortingHat") { vc in
                            let actionUrl = "/handler/story/comment?content=Hello,SortingHat"
                            let actionResult = (SortingHat.handle(url: actionUrl) as? String) ?? "Action handler parse error!"
                            let alert = UIAlertController(title: "URLHandler", message: actionResult, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            vc.present(alert, animated: true, completion: nil)
                        }]),
        ]
    }
}

