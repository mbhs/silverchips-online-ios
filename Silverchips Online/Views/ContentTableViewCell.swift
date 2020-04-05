//
//  ContentTableViewCell.swift
//  Silverchips Online
//
//  Created by Matthew on 4/4/20.
//  Copyright © 2020 Technaplex. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
