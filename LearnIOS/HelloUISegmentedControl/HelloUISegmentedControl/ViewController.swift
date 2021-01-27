//
//  ViewController.swift
//  HelloUISegmentedControl
//
//  Created by eavictor on 2020/12/16.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func segmentedControlBGColor(_ sender: UISegmentedControl) {
        let selectedIndex:Int = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            self.view.backgroundColor = UIColor.white
        case 1:
            self.view.backgroundColor = UIColor.black
        case 2:
            self.view.backgroundColor = UIColor.blue
        case 3:
            self.view.backgroundColor = UIColor.green
        case 4:
            self.view.backgroundColor = UIColor.red
        default:
            self.view.backgroundColor = UIColor.white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
