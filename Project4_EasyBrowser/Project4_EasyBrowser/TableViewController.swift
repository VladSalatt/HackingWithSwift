//
//  TableViewController.swift
//  Project4_EasyBrowser
//
//  Created by Effrafax Bulwer on 7/14/21.
//  Copyright © 2021 Effrafax Bulwer. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Web") as? ViewController {
            vc.selectedWebsites = websites[indexPath.row]
            vc.rootVC = self
            navigationController?.pushViewController(vc, animated: false)
        } else {
            fatalError("Failed with instantiate from storyboard")
        }
    }
}
