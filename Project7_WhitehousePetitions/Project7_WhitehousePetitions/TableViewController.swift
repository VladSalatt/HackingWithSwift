//
//  ViewController.swift
//  Project7_WhitehousePetitions
//
//  Created by Effrafax Bulwer on 8/3/21.
//  Copyright © 2021 Effrafax Bulwer. All rights reserved.
//

import UIKit

private enum Constants {
    static let cellId = "cellId"
    static let urlStringFirst = "https://www.hackingwithswift.com/samples/petitions-1.json"
    static let urlStringSecond = "https://www.hackingwithswift.com/samples/petitions-2.json"
}

class TableViewController: UITableViewController {

    var sortedPetitions = [Petition]()
    var petitions = [Petition]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarConfigure()
        
        // Это нужно для того, чтобы в зависимости от тега определить, контент с какого URL загружать
        let urlString = navigationController?.tabBarItem.tag == 0 ? Constants.urlStringFirst : Constants.urlStringSecond
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    func navBarConfigure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(moreTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Plz, check connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }

    // MARK: Selectors
    
    @objc func moreTapped() {
        let ac = UIAlertController(title: "Info", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    @objc func searchTapped() {
        
        let ac = UIAlertController(title: "Search petition", message: "enter your petition", preferredStyle: .alert)
        
        // Добавляем TextField в AlertVC
        ac.addTextField()
        
        let action = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
            
            // Считываем строку из TextField
            guard let word = ac?.textFields?[0].text else { return }

            self?.filterPetition(word)
        }
        ac.addAction(action)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.sortedPetitions = self.petitions
            self.tableView.reloadData()
        }
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true)
    }
    
    func filterPetition(_ word: String) {
        if word.isEmpty { return }

        let lowerWord = word.lowercased()
        self.sortedPetitions.removeAll(keepingCapacity: true)
        
        for petition in self.petitions {
            let lowerTitle = petition.title
            let lowerBody = petition.body
            
            if lowerTitle.contains(lowerWord) || lowerBody.contains(lowerWord) {
                self.sortedPetitions.append(petition)
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: Networking
    
    func parse(json: Data) {
        // Декодер нужен для преобразования между JSON и Codable объектами
        let decoder = JSONDecoder()
        
        // Вызывает метод decode(), который пытается преобразовать данные переменной json в Petitions объект
        // Строка Petitions.self указывает на сам ТИП объекта
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            sortedPetitions = jsonPetitions.results
            petitions = sortedPetitions
            tableView.reloadData()
        }
    }

    // MARK: TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Создаем ячейку исходя из ее id
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId)

        // Делаем эту ячейку стиля subtitle
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellId)
        }

        cell?.textLabel?.text = sortedPetitions[indexPath.row].title
        cell?.detailTextLabel?.text = sortedPetitions[indexPath.row].body
        return cell!
    }
    
    // Переход на экран детального представления
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.detailItem = sortedPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

