//
//  ViewController.swift
//  HelloTabBarAgain
//
//  Created by eavictor on 2020/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let secondViewController = self.tabBarController?.viewControllers?[1] as? SecondViewController {
            secondViewController.labelText = mainLabel.text
        }
    }


}
