//
//  RecordTableViewCell.swift
//  00457149
//
//  Created by User16 on 2018/6/27.
//  Copyright © 2018年 User21. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
