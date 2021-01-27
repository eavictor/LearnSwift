//
//  ViewController.swift
//  HelloTableView
//
//  Created by eavictor on 2020/12/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fruits:[String] = ["apple", "banana", "mango", "watermelon"]
    var colors:[String] = ["red", "green", "blue"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fruits.count
        } else {
            return colors.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell() // memory expansive, don't use
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) // reuse cell, good
        
        if indexPath.section == 0 {
            cell.textLabel?.text = fruits[indexPath.row]
        } else {
            cell.textLabel?.text = colors[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Fruit"
        } else {
            return "Color"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

