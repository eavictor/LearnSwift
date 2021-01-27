//
//  ContentViewController.swift
//  MyBook
//
//  Created by eavictor on 2020/12/30.
//

import UIKit

class ContentViewController: UIViewController {
    
    var currentPageNumber:Int = 0
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.image = UIImage(named: "\(currentPageNumber)")
    }
}
