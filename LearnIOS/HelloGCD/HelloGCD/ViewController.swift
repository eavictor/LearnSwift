//
//  ViewController.swift
//  HelloGCD
//
//  Created by eavictor on 2020/12/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let task1 = {
            for i in 1...5 {
                print("Task1: \(i)")
            }
        }
        let task2 = {
            for i in 1...5 {
                print("Task2: \(i)")
            }
        }
        DispatchQueue.global().async(execute: task1)
        DispatchQueue.global().async(execute: task2)
    }


}

