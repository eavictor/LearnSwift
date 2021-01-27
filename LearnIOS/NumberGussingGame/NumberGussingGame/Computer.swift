//
//  Computer.swift
//  NumberGussingGame
//
//  Created by eavictor on 2020/12/31.
//

class Computer: Basic {
    var answerNumberString:String = ""
    var guessCount:Int = 0
    
    func generateAnswerNumberString() -> Void {
        var numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for _ in 0..<MAX_NUMBER {
            let index = Int.random(in: 0..<numbers.count)
            let number = numbers[index]
            
            answerNumberString += number
            
            if ALLOW_DUPLICATE_NUMBER == false {
                numbers.remove(at: index)
            }
        }
    }
    
    func userGuess(input:String) -> (A:Int, B:Int)? {
        let answer = checkAB(test: input, answer: self.answerNumberString)
        if answer != nil {
            guessCount += 1
        }
        return answer
    }
    
    override init() {
        super.init()
        self.generateAnswerNumberString()
        print("Anwer: \(answerNumberString)")
    }
    
}
