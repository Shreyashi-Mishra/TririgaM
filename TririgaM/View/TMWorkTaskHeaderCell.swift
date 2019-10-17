//
//  TMWorkTaskHeaderCell.swift
//  POC
//
//  Created by Kondaiah Veeraboyina on 08/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

class TMWorkTaskHeaderCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var img_view: UIView!
    @IBOutlet weak var img_type: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_add: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func displayInformation(model: TMWorkTaskHeaderModel, section: Int) -> Void {
        
        // display information...
        img_type.image = UIImage.init(named: (model.image ?? "ic_camera"))
        lbl_title.text = model.name ?? ""
        
        btn_add.isHidden = true
        if section == 0 {
            //btn_add.isHidden = false
        }
    }
    
    // MARK:-
    @IBAction func leftAddButtonClicked(_ sender: UIButton) {
        print("Left button clicked")
    }
    
    @IBAction func rightAddButtonClicked(_ sender: UIButton) {
        print("Right button clicked")
    }
}
