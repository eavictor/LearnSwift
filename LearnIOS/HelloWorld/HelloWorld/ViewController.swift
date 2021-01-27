//
//  ViewController.swift
//  HelloWorld
//
//  Created by eavictor on 2020/12/9.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        myLabel.text = "Hello World"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
