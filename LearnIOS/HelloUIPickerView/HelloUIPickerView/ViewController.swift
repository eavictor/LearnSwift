//
//  ViewController.swift
//  HelloUIPickerView
//
//  Created by eavictor on 2020/12/19.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let numberArray = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let fruitArray = ["apple", "banana", "mango", "watermelon"]
    
    // How many components in PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // How many rows per component in PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numberArray.count
        } else {
            return fruitArray.count
        }
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return numberArray[row]
        } else {
            return fruitArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print(numberArray[row])
        } else {
            print(fruitArray[row])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

