//
//  ViewController.swift
//  HelloUISwitch
//
//  Created by eavictor on 2020/12/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBAction func makeAChange(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch ON")
            self.view.backgroundColor = UIColor.white
        } else {
            print("Switch OFF")
            self.view.backgroundColor = UIColor.black
        }
    }
    
    @objc func codeSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch ON")
        } else {
            print("Switch OFF")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Switch and Background initial status
        mySwitch.isOn = false
        // Method 1: set status directly
        // self.view.backgroundColor = UIColor.black
        // Method 2: set by passing switch object
        makeAChange(mySwitch)
        
        // Generate a switch by code
        let a = CGRect(x: view.frame.midX - 51/2, y: view.frame.maxY - 100, width: 51, height: 31)
        let codeSwitch = UISwitch(frame: a)
        codeSwitch.isOn = true
        codeSwitch.addTarget(self, action: #selector(ViewController.codeSwitchChange(_: )), for: .valueChanged)
        self.view.addSubview(codeSwitch)
    }
}
