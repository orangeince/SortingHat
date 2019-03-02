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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            SortingHat.show(target: ModuleCenter.Demo.detail(title: "Sorting.detail"), from: self)
        case 1:
            SortingHat.show(targetUrl: URL(string: "x://list1/?title=SortingHat.list1&id=10")!, from: self)
        case 2:
            SortingHat.show(targetUrl: URL(string: "x://list2/?title=SortingHat.list2&id=10")!, from: self)
        default:
            break
        }
    }
}

