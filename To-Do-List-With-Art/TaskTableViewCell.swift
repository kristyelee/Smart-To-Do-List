//
//  TaskTableViewCell.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/28/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var timeName: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkButton.layer.cornerRadius = checkButton.frame.size.width / 2
        checkButton.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        checkButton.layer.borderWidth = 2.0
        checkButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
