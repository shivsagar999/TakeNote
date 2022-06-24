//
//  NotesListCell.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 23/06/22.
//

import UIKit

class NotesListCell: UITableViewCell {
    
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDescription: UILabel!
    @IBOutlet weak var lastEditDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
