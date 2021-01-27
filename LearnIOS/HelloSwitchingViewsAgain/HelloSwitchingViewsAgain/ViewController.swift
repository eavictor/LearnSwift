//
//  ViewController.swift
//  HelloSwitchingViewsAgain
//
//  Created by eavictor on 2020/12/24.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func gotoView2(_ sender: UIButton) {
        // Get light red background view
        let lightRed = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "lightRed")
        // Switch to view (affect: from bottom to top)
        // present(lightRed, animated: true, completion: nil)
        // Switch to view (affect: from right to left)
        self.navigationController?.pushViewController(lightRed, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class SecondViewController: UIViewController {
    
    @IBAction func gotoView3(_ sender: UIButton) {
        let lightGreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "lightGreen")
        
        present(lightGreen, animated: true, completion: nil)
        //self.navigationController?.pushViewController(lightGreen, animated: true)
    }
    
    @IBAction func backToView1(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class ThirdViewController: UIViewController {
    
    @IBAction func backToView2(_ sender: UIButton) {
        // go back to previous view
        dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
