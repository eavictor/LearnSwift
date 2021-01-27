//
//  SpecialTableViewCell.swift
//  HelloTableView
//
//  Created by eavictor on 2020/12/25.
//

import UIKit

class SpecialTableViewCell: UITableViewCell {

    @IBOutlet weak var specialImageView: UIImageView!
    
    @IBOutlet weak var specialImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
