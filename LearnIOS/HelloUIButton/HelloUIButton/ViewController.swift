//
//  ViewController.swift
//  HelloUIButton
//
//  Created by eavictor on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonPressed(_ sender: UIButton) {
        print("Hello World")
    }
    
    @objc func hitMe(_ thisButton:UIButton) {
        print("Yo V, a pleasure.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // How to make system style button via code
        let newButton = UIButton(type: UIButton.ButtonType.system)
        newButton.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        newButton.setTitle("Press", for: UIControl.State.normal)
        newButton.setTitle("Pressing", for: UIControl.State.highlighted)
        newButton.addTarget(self, action: #selector(ViewController.hitMe(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(newButton)
        
        // How to make image button via code
        let imgButton = UIButton(type: UIButton.ButtonType.custom)
        imgButton.frame = CGRect(x: 200, y: 200, width: 114, height: 54)
        imgButton.setImage(UIImage(named: "PlayButton"), for: UIControl.State.normal)
        imgButton.setImage(UIImage(named: "PlayButtonPressed"), for: UIControl.State.highlighted)
        imgButton.addTarget(self, action: #selector(ViewController.hitMe(_:)), for:UIControl.Event.touchUpInside)
        self.view.addSubview(imgButton)
    }


}

