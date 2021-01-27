//
//  Basic.swift
//  NumberGussingGame
//
//  Created by eavictor on 2020/12/31.
//

import Foundation

class Basic {
    
    let MAX_NUMBER:Int = 4
    let ALLOW_DUPLICATE_NUMBER:Bool = false
    
    func isOKNumber(input:String) -> Bool {
        // check length
        if input.count != MAX_NUMBER {
            return false
        }
        // check if is number
        if Int(input) == nil {
            return false
        }
        // check duplicate numbers
        if !ALLOW_DUPLICATE_NUMBER {
            let inputArray = Array(input)
            let inputSet = Set(inputArray)
            if inputSet.count != inputArray.count {
                return false
            }
        }
        // passed all tests
        return true
    }
    
    func checkAB(test:String, answer:String) -> (A:Int, B:Int)? {
        if !self.isOKNumber(input: test) || !self.isOKNumber(input: answer) {
            return nil
        }
        var resultA = 0
        var resultB = 0
        let testArray = Array(test)
        let answerArray = Array(answer)
        for i in 0..<MAX_NUMBER {
            for j in 0..<MAX_NUMBER {
                if testArray[i] == answerArray[j] {
                    if i == j {
                        resultA += 1
                    } else {
                        resultB += 1
                    }
                }
            }
        }
        return (resultA, resultB)
    }
    
}
