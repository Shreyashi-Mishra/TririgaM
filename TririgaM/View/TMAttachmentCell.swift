//
//  AttachmentTableViewCell.swift
//  Poc
//
//  Created by Shreyashi Mishra on 08/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

protocol AttachmentHeaderCellDelegate: class {
    func attachmentTapped()
}

class TMAttachmentCell: UITableViewCell {

   //Mark: - IBOutlet
    @IBOutlet weak var attachmentLabel: UILabel!
    
    weak var delegate: AttachmentHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func attachButtonTapped(_ sender: Any) {
           delegate?.attachmentTapped()
           
       }
}
