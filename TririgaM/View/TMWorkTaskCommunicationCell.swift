//
//  TMWorkTaskCommunicationCell.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

class TMWorkTaskCommunicationCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayInformation(model: TMWorkTaskCommunicationModel) -> Void {
        
        // display information...
        lbl_name.text = model.name ?? ""
        lbl_description.text = model.description ?? ""
    }
}
