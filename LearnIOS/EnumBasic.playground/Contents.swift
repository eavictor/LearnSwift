enum NameInputError:Error {
    case empty
    case isNumber
}

func getUserFullName(firstName:String, lastName:String) throws -> String {
    if firstName == "" || lastName == "" {
        throw NameInputError.empty
    } else if Int(firstName) != nil || Int(lastName) != nil {
        throw NameInputError.isNumber
    }
    return firstName + " " + lastName
}

do{
    try getUserFullName(firstName: "Victor", lastName: "Chen")
} catch NameInputError.empty {
    print("Empty name.")
} catch NameInputError.isNumber {
    print("Number entered")
} catch {
    print("Something wrong")
}
