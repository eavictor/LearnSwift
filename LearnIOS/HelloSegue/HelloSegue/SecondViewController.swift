//
//  SecondViewController.swift
//  HelloSegue
//
//  Created by eavictor on 2020/12/24.
//

import UIKit

protocol LightRedViewControllerDelegate {
    func setColor(colorType: String) -> Void
}

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var infoFromViewOne:String?
    var delegate:LightRedViewControllerDelegate?
    
    var colors = ["red", "green", "blue"]
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return colors.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return colors[row]
        } else {
            return "X"
        }
    }
    
    
    @IBAction func backToView1(_ sender: UIButton) {
        let selectedColorIndex:Int = myPickerView.selectedRow(inComponent: 0)
        let selectedColor:String = colors[selectedColorIndex]
        delegate?.setColor(colorType: selectedColor)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myPickerView.dataSource = self
        myPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myLabel.text = infoFromViewOne!
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
