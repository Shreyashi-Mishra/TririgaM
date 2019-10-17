//
//  TMWorkTaskResourceCell.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

class TMWorkTaskResourceCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var btn_mail: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btn_mail.isHidden = true
        btn_cancel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayInformation(model: TMWorkTaskResourcesModel) -> Void {
        
        // display information...
        lbl_name.text = model.name ?? ""
        lbl_status.text = model.status ?? ""
    }
    
    @IBAction func emailButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
    }
}
