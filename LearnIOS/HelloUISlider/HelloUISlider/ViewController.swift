//
//  ViewController.swift
//  HelloUISlider
//
//  Created by eavictor on 2020/12/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func mySlider(_ sender: UISlider) {
        myLabel.text = "\(sender.value)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

