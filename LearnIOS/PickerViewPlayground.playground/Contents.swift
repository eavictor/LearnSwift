protocol PickerViewDataSource {
    func howManyComponents() -> Int
}

protocol PickerViewDelegate {
    func titleToShow() -> String
    func didSelect() -> Bool
}

class ViewController: PickerViewDataSource, PickerViewDelegate {
    func howManyComponents() -> Int {
        return 1
    }
    func titleToShow() -> String {
        return "PickerView"
    }
    func didSelect() -> Bool {
        return true
    }
}

class PickerView {
    var dataSource:PickerViewDataSource?
    var delegate:PickerViewDelegate?
    func howManyComponentsIHave() -> Int {
        return dataSource?.howManyComponents() ?? 0
    }
    func whatToShow() -> String {
        return delegate?.titleToShow() ?? ""
    }
    func afterSelect() -> Bool {
        return delegate?.didSelect() ?? false
    }
}

let aPickerView = PickerView()
aPickerView.dataSource = ViewController()
aPickerView.delegate = ViewController()
print(aPickerView.howManyComponentsIHave())
