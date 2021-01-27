protocol SoyMildGetable {
    func giveMeSoyMilk() -> String
}

class Brunch: SoyMildGetable {
    func giveMeSoyMilk() -> String {
        print("SoyMilk")
        return "SoyMilk"
    }
}
let aBrunch = Brunch()
aBrunch.giveMeSoyMilk()


protocol MoneyTransferProtocol {
    func giveMoney() -> Int
}

class RichPeople: MoneyTransferProtocol {
    func giveMoney() -> Int {
        return Int.random(in: 1...100)
    }
}

class PoorPeople {
    var helper:MoneyTransferProtocol?
    
    func needMoney() -> Int{
        let money:Int? = helper?.giveMoney()
        return money ?? 0
    }
}

let poor = PoorPeople()
poor.helper = RichPeople()
let amount = poor.needMoney()
print(amount)
