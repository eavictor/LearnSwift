let num:Int = 199


func checkPrime(_ testNumber:Int) -> Bool? {
    var isPrime:Bool? = true
    
    if testNumber <= 0 {
        isPrime = nil
    } else if testNumber == 1 {
        isPrime = false
    } else {
        let highest:Int = 5 / 2
        for index in 2...highest {
            if (testNumber % index) == 0 {
                isPrime = false
                break
            }
        }
    }
    return isPrime
}

checkPrime(num)
