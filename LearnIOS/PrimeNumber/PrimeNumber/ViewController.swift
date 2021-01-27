//
//  ViewController.swift
//  PrimeNumber
//
//  Created by eavictor on 2020/12/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textInputField: UITextField!
    
    @IBAction func primeTestButton(_ sender: UIButton) {
        // 0. Definition
        var isPrime:Bool? = true
        
        // 1. Read input number from screen's text input field
        let inputNumber:Int = Int(textInputField.text ?? "0") ?? 0
        
        // 2. Calculate prime number
        if inputNumber <= 0 {
            isPrime = nil
        } else if inputNumber == 1 {
            isPrime = false
        } else if [2, 3].contains(inputNumber) {
            isPrime = true
        } else {
            for i in 2...inputNumber/2 {
                if inputNumber % i == 0 {
                    isPrime = false
                    break
                }
            }
        }
        
        // 3. Display prime calculation result on screen
        if let prime = isPrime {
            if prime {
                textLabel.text = "Is Prime"
            } else {
                textLabel.text = "Not Prime"
            }
        } else {
            textLabel.text = "Please enter number >= 1"
        }
        
        // 4. Unhide textLabel, display input number is prime or not
        textLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Push keyboard up when load
        textInputField.becomeFirstResponder()
    }
}
