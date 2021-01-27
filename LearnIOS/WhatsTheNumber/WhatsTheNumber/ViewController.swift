//
//  ViewController.swift
//  WhatsTheNumber
//
//  Created by eavictor on 2020/12/11.
//

import UIKit

class ViewController: UIViewController {
    
    // Make a random number
    var answer:Int = Int.random(in: 1...100)
    // Initial min & max number
    var minNumber:Int = 1
    var maxNumber:Int = 100
    // User guessed correct number
    var isOver:Bool = false

    @IBOutlet weak var messageLabel: UILabel!
    
    // If keyboard not popping up in siumlator, click on Simulator then select "I/O" -> "Keyboard" -> uncheck "Connect Hardware Keyboard"
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func makeAGuess(_ sender: UIButton) {
        if isOver {
            // Guessed correct answer, pressed Guess button again.
            // Reset environment
            maxNumber = 100
            minNumber = 1
            answer = Int.random(in: 1...100)
            messageLabel.text = "Guess a number between \(minNumber)~\(maxNumber)"
        } else {
            // Playing
            // take input text out
            let inputText = inputTextField.text!
            let inputNumber = Int(inputText)
            
            if inputNumber == nil {
                messageLabel.text = "Guess a number between \(minNumber)~\(maxNumber)"
            } else {
                if inputNumber! > maxNumber {
                    messageLabel.text = "Too large. Guess a number between \(minNumber)~\(maxNumber)"
                } else if inputNumber! < minNumber {
                    messageLabel.text = "Too small. Guess a number between \(minNumber)~\(maxNumber)"
                } else {
                    if inputNumber == answer {
                        isOver = true
                        messageLabel.text = "Correct. Press [Guess] again to play again."
                    } else {
                        if answer > inputNumber! {
                            minNumber = inputNumber!
                        } else {
                            maxNumber = inputNumber!
                        }
                        messageLabel.text = "Guess a number between \(minNumber)~\(maxNumber)"
                    }
                    // Clear input text field
                    inputTextField.text = ""
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Auto focus on this component, push keyboard up when launching this app.
        inputTextField.becomeFirstResponder()
    }
}

