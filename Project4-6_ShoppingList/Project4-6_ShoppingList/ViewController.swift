//
//  ViewController.swift
//  Project4-6_ShoppingList
//
//  Created by Effrafax Bulwer on 7/19/21.
//  Copyright © 2021 Effrafax Bulwer. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItemConfigure()
    }
    
    func navigationItemConfigure() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [addButton, shareButton]
    }
    

}

// MARK: TableView DataSource

extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

// MARK: Local Methods

extension ViewController {

    @objc func addTapped() {
        let ac = UIAlertController(title: "Add your item", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.shoppingList.insert(item, at: 0)

            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func refreshTapped() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareTapped() {
        let shareList = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [shareList], applicationActivities: [])
        present(vc, animated: true)
    }
}

