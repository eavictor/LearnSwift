//
//  SecondViewController.swift
//  HelloTabBarAgain
//
//  Created by eavictor on 2020/12/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    var labelText:String?
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBAction func ok(_ sender: UIButton) {
        if let text:String = textInput.text {
            print(text)
            
            textInput.text = ""
            textInput.resignFirstResponder() // close keyboard
            
            // pass current to label on first view
            if let viewController = self.tabBarController?.viewControllers?[0] as? ViewController {
                viewController.mainLabel.text = text
            }
        }
        self.tabBarController?.selectedIndex = 0 // Switch to view one
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textInput.text = labelText // apply text came from view one, value will update when switch back to view one
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textInput.becomeFirstResponder() // open keyboard
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
