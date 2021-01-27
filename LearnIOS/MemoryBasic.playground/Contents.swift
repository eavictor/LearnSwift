class Person {
    var firstName:String = "Victor"
    var lastName:String = "Chen"
    var fullName:String
    
    init() {
        print("Person init")
        fullName = "\(firstName)+\(lastName)"
    }
    
    init(firstName:String, lastName:String) {
        print("Person init 2 variables")
        self.firstName = firstName
        self.lastName = lastName
        fullName = "\(firstName)+\(lastName)"
    }
    
    deinit {
        print("Person deinit")
    }
}

var person1:Person? = Person()
var person2:Person? = Person()
