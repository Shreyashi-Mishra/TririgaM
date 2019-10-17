//
//  AttachmentTableViewCell.swift
//  Attachments
//
//  Created by Sharvari H V on 10/3/19.
//  Copyright © 2019 Sharvari H V. All rights reserved.
//

import UIKit

protocol AttachmentCellDelegate: class {
    func deleteButton(cell : UITableViewCell)
}


class TMAttachmentTableViewCell: UITableViewCell {
    
    // var isCoordinator = true for hiding delete button
    
    @IBOutlet weak var attachmentName: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var cellDelegate : AttachmentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setViewDetails(_ details : AttachmentModel) {
        attachmentName.text = details.fileName
        deleteButton.isHidden = details.delete_flag ?? true
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        cellDelegate?.deleteButton(cell: self)
    }
}
