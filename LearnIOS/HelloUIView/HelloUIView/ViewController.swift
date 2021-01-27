//
//  ViewController.swift
//  HelloUIView
//
//  Created by eavictor on 2020/12/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var midRect: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Set background color
        // midRect.backgroundColor = UIColor.green
        // Set transparency (0.0~1.0)
        // midRect.alpha = 0.5
        // Hide midRect from screen
        // midRect.isHidden = true
        self.view.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.8, alpha: 1.0)
        // Get UIView by tag number, then change it's background color
        // self.view.viewWithTag(101)?.backgroundColor = UIColor.lightGray
        
        // Create an UIView by code
        let viewArea:CGRect = CGRect(x: 50, y: 400, width: 100, height: 50)
        let smallRect:UIView = UIView(frame: viewArea)
        smallRect.backgroundColor = UIColor.purple
        smallRect.tag = 103 // assign a tag number
        // Add created rectangle to view controller
        self.view.addSubview(smallRect)
    }

}
