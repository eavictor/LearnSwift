//
//  ViewController.swift
//  HelloSegue
//
//  Created by eavictor on 2020/12/24.
//

import UIKit

class ViewController: UIViewController, LightRedViewControllerDelegate {
    
    private let secondViewSegue:String = "GotoView2"
    
    @IBOutlet weak var myTextInput: UITextField!
    
    @IBAction func gotoView2(_ sender: UIButton) {
        if let inputText:String = myTextInput.text {
            if inputText == "" {
                // no string, pop up alert
                let myAlert:UIAlertController = UIAlertController(title: "No Input", message: "Please enter something", preferredStyle: UIAlertController.Style.alert)
                let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                myAlert.addAction(okAction)
                present(myAlert, animated: true, completion: nil)
            } else {
                // pass string and switch to next view
                performSegue(withIdentifier: secondViewSegue, sender: inputText)
                myTextInput.text = ""
            }
        }
    }
    
    func setColor(colorType: String) {
        print(colorType)
        switch colorType {
            case "red":
                self.view.backgroundColor = UIColor.red
            case "green":
                self.view.backgroundColor = UIColor.green
            case "blue":
                self.view.backgroundColor = UIColor.blue
            default:
                self.view.backgroundColor = UIColor.white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == secondViewSegue {
            if let lightRed = segue.destination as? SecondViewController {
                lightRed.infoFromViewOne = sender as? String
                lightRed.delegate = self
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTextInput.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        myTextInput.resignFirstResponder()
    }


}

