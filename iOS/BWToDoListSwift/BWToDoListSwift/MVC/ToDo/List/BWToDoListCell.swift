//
//  BWToDoListCell.swift
//  BWToDoListSwift
//
//  Created by BobWong on 2018/6/22.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

import UIKit

class BWToDoListCell: UITableViewCell {
    
    @IBOutlet public weak var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
