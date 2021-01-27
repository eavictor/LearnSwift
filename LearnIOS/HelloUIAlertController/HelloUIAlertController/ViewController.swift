//
//  ViewController.swift
//  HelloUIAlertController
//
//  Created by eavictor on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showAlert(_ sender: UIButton) {
        let myAlert:UIAlertController = UIAlertController(title: "Hello", message: "Alert Controller", preferredStyle: .actionSheet)
        
        let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let helloAction:UIAlertAction = UIAlertAction(title: "Hello", style: .destructive) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (action:UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        myAlert.addAction(helloAction)
        myAlert.addAction(cancelAction)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

