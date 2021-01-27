//
//  ViewController.swift
//  Calculator
//
//  Created by eavictor on 2020/12/19.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0.0
    var previousNumber:Double = 0.0
    var performingMath:Bool = false
    var operation:String = "none"
    var startNew:Bool = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    @IBOutlet weak var label: UILabel!
    
    func makeOKNumberString(from number:Double) -> String {
        if floor(number) == number { // check if number is Integer
            return "\(Int(number))"
        } else {
            return "\(number)"
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        let inputNumber = sender.tag - 1 // default tag is 0, so we have to minus 1
        if label.text != nil {
            if startNew {
                label.text = "\(inputNumber)"
            } else {
                if label.text == "0" || label.text == "+" || label.text == "-" || label.text == "x" || label.text == "/" {
                    label.text = "\(inputNumber)"
                } else {
                    label.text = label.text! + "\(inputNumber)"
                }
            }
            numberOnScreen = Double(label.text!) ?? 0.0
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        numberOnScreen = 0.0
        previousNumber = 0.0
        performingMath = false
        operation = "none"
        startNew = true
    }
    
    @IBAction func add(_ sender: UIButton) {
        label.text = "+"
        operation = "add"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func substract(_ sender: UIButton) {
        label.text = "-"
        operation = "substract"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "x"
        operation = "multiply"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func divide(_ sender: UIButton) {
        label.text = "/"
        operation = "divide"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        if performingMath {
            if operation == "add" {
                numberOnScreen = previousNumber + numberOnScreen
                previousNumber = 0.0
                label.text = makeOKNumberString(from: numberOnScreen)
            } else if operation == "substract" {
                numberOnScreen = previousNumber - numberOnScreen
                previousNumber = 0.0
                label.text = makeOKNumberString(from: numberOnScreen)
            } else if operation == "multiply" {
                numberOnScreen = previousNumber * numberOnScreen
                previousNumber = 0.0
                label.text = makeOKNumberString(from: numberOnScreen)
            } else if operation == "divide" {
                if numberOnScreen == 0 {
                    label.text = "Err divide by 0"
                } else {
                    numberOnScreen = previousNumber / numberOnScreen
                    previousNumber = 0.0
                    label.text = makeOKNumberString(from: numberOnScreen)
                }
            } else {
                label.text = "0"
            }
            performingMath = false
            startNew = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

