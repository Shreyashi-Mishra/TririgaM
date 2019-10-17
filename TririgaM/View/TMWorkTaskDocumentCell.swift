//
//  TMWorkTaskDocumentCell.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

class TMWorkTaskDocumentCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var lbl_name: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayInformation(model: TMWorkTaskDocumentModel) -> Void {
        
        // display informations
        lbl_name.text = model.name ?? ""
    }
}
