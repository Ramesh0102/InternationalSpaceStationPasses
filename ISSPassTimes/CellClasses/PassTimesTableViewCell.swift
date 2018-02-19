//
//  PassTimesTableViewCell.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/9/18.
//  Copyright © 2018 valador. All rights reserved.
//

import UIKit

class PassTimesTableViewCell: UITableViewCell {
    @IBOutlet weak var serialNo: UILabel!
    @IBOutlet weak var passTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
