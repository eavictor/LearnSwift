//
//  ViewController.swift
//  HelloUserDefaults
//
//  Created by eavictor on 2020/12/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set info into UserDefaults
        UserDefaults.standard.set("Victor", forKey: "name")
        // Get info from UserDefaults
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            print(name)
        }
        
        let fruits = ["apple", "banana", "mango"]
        UserDefaults.standard.set(fruits, forKey: "fruits")
        if let loadedFruits = UserDefaults.standard.value(forKey: "fruits") as? [String] {
            print(loadedFruits)
        }
    }


}

