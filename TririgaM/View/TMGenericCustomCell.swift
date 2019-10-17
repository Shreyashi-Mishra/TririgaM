//
//  CustomTableViewCell.swift
//  Poc
//
//  Created by Shreyashi Mishra on 03/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMGenericCustomCell: UITableViewCell {
    
    //Mark: - IBOutlets
    @IBOutlet weak var customImageView: UIImageView!
    
    @IBOutlet weak var customLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setDataModel(dataM : TMGenericDataModel){
        customImageView.image = dataM.genericImageData
        customLabel.text = dataM.genericDataLabel
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
