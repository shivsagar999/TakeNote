//
//  CategoryCell.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 30/06/22.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
