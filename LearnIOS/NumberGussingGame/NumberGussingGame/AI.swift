//
//  AI.swift
//  NumberGussingGame
//
//  Created by eavictor on 2021/1/1.
//

class AI: Basic {
    var allPossibilities:[String] = []
    var lastGuess:String?
    var aiGuessCount:Int = 0
    
    func aiAnswer() -> String? {
        if allPossibilities.count == 0 {
            return nil
        }
        let index = Int.random(in: 0...allPossibilities.count)
        let answer = allPossibilities[index]
        aiGuessCount += 1
        lastGuess = answer
        return answer
    }
    
    func userReply(replyA:Int, replyB:Int) -> Bool? {
        // nil: game should restart
        // true: ai win
        // false: continue
        if allPossibilities.count == 0 || lastGuess == nil {
            return nil
        } else if replyA == self.MAX_NUMBER {
            return true
        }
        
        var newPossibilities:[String] = []
        for number in allPossibilities {
            let tempAB = checkAB(test: number, answer: lastGuess!)
            if tempAB == nil {
                return nil
            } else if tempAB!.A == replyA && tempAB!.B == replyB {
                newPossibilities.append(number)
            }
        }
        allPossibilities = newPossibilities
        print("Total: \(allPossibilities.count) numbers.")
        
        return false
    }
    
    func getAllPossibilities() -> Void {
        var startNumber:Int = 0
        var endNumber:Int = 0
        // Decide start & end numbers
        if self.ALLOW_DUPLICATE_NUMBER {
            for _ in 0..<self.MAX_NUMBER {
                endNumber *= 10
                endNumber += 9
            }
        } else {
            for i in 0..<self.MAX_NUMBER {
                startNumber *= 10
                startNumber += i
                endNumber *= 10
                endNumber += 9 - i
            }
        }
        
        let formatString = String(format: "%%0%dd", endNumber)
        for i in startNumber...endNumber {
            let tempNumber = String(format: formatString, i)
            if isOKNumber(input: tempNumber) {
                allPossibilities.append(tempNumber)
            }
        }
        print("Total: \(allPossibilities.count) numbers.")
    }
}
