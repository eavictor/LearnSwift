//
//  ViewController.swift
//  ColorFinder
//
//  Created by eavictor on 2020/12/17.
//

import UIKit

class ViewController: UIViewController {
    
    var redValue:Float = 255.0
    var greenValue:Float = 255.0
    var blueValue:Float = 255.0

    @IBOutlet weak var redText: UILabel!
    @IBOutlet weak var greenText: UILabel!
    @IBOutlet weak var blueText: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBAction func redSliderChanged(_ sender: UISlider) {
        redValue = sender.value
        redText.text = "R:\(Int(sender.value))"
        updateViewBackgroundColor()
    }
    
    @IBOutlet weak var greenSlider: UISlider!
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        greenValue = sender.value
        greenText.text = "G:\(Int(sender.value))"
        updateViewBackgroundColor()
    }
    
    @IBOutlet weak var blueSlider: UISlider!
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        blueValue = sender.value
        blueText.text = "B:\(Int(sender.value))"
        updateViewBackgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Force initial value = 255
        redSlider.value = Float(redValue)
        greenSlider.value = Float(greenValue)
        blueSlider.value = Float(blueValue)
    }

    func updateViewBackgroundColor() {
        view.backgroundColor = UIColor(red: CGFloat(redValue / 255.0), green: CGFloat(greenValue / 255), blue: CGFloat(blueValue / 255), alpha: 1)
    }

}
