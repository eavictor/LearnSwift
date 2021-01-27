struct SizeStruct {
    var width:Float = 1.0
    var height:Float = 1.0
    func area() -> Float {
        return width * height
    }
}


class SizeClass {
    var width:Float = 1.0
    var height:Float = 1.0
    func area() -> Float {
        return width * height
    }
}

var cls1 = SizeClass()
var cls2 = cls1
cls1.width = 100.0
print(cls2.width)

var struct1 = SizeStruct()
var struct2 = struct1
struct1.width = 100.0
print(struct2.width)
