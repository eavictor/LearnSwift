//
//  DetailViewController.swift
//  HelloTableView
//
//  Created by eavictor on 2020/12/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var infoFromViewOne:String? // receive animal name from AnimalTableViewController
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if infoFromViewOne != nil {
            myLabel.text = infoFromViewOne
            myImageView.image = UIImage(named: infoFromViewOne!)
        }
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
