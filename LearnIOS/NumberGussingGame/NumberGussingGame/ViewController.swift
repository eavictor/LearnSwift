//
//  ViewController.swift
//  NumberGussingGame
//
//  Created by eavictor on 2020/12/31.
//

import UIKit

class ViewController: UIViewController {
    
    var computer:Computer = Computer()
    var ai:AI = AI()

    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var inputA: UITextField!
    @IBOutlet weak var inputB: UITextField!
    @IBOutlet weak var playerLog: UITextView!
    @IBOutlet weak var computerLog: UITextView!
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        computerLog.text = "Game reset.\nplease guess first.\n"
        computer = Computer()
        ai = AI()
        playerLog.text = ""
    }
    
    @IBAction func guess(_ sender: UIButton) {
        guard let guessText = guessTextField.text else { return }
        guessTextField.text = ""
        if !computer.isOKNumber(input: guessText) {
            computerLog.text += "Wrong input: \(guessText)\nPlease guess again.\n"
        }
        guard let result = computer.userGuess(input: guessText) else { return }
        playerLog.text += "[\(computer.guessCount)]: \(guessText) ==> \(result.A)A, \(result.B)B\n"
        if result.A == computer.MAX_NUMBER {
            playerLog.text += "Player win, tap Reset to start another round.\n"
            return
        }
        if let aiGuessNumber = ai.aiAnswer() {
            computerLog.text += "[\(ai.aiGuessCount)]: \(aiGuessNumber)\n"
        } else {
            computerLog.text += "Computer don't know how to guess, please tap Reset to start another round.\n"
        }
    }
    
    @IBAction func reply(_ sender: UIButton) {
        guard let replyA = inputA.text, let replyB = inputB.text else { return }
        inputA.text = ""
        inputB.text = ""
        if replyA == "" || replyB == "" {
            if replyA == "" {
                computerLog.text += "A is required.\n"
            }
            if replyB == "" {
                computerLog.text += "B is required.\n"
            }
            return
        }
        let numberA = Int(replyA)
        let numberB = Int(replyB)
        if numberA == nil || numberB == nil {
            if numberA == nil {
                computerLog.text += "A contains invalid char.\n"
            }
            if numberB == nil {
                computerLog.text += "B contains invallid char.\n"
            }
            return
        }
        let result = ai.userReply(replyA: numberA!, replyB: numberB!)
        if result == nil {
            computerLog.text += "Something went wrong, tap Reset to start another round.\n"
        } else if result! {
            computerLog.text += "Computer win.\n"
        } else {
            computerLog.text += "==>\(replyA)A,\(replyB)B\n"
            computerLog.text += "Player's turn to guess.\n"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerLog.text = "----- Player -----\nHello"
        computerLog.text = "----- Computer -----\nHello"
        computerLog.text += "Welcome, please guess first.\n"
    }


}

