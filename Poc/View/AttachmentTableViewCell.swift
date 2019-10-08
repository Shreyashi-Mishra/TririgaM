//
//  AttachmentTableViewCell.swift
//  Poc
//
//  Created by Shreyashi Mishra on 08/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var attachmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
