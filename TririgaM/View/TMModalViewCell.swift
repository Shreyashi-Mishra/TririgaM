//
//  TMModalViewCell.swift
//  TririgaM
//
//  Created by Shreyashi Mishra on 10/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

class TMModalViewCell: UITableViewCell {
    
    //Mark: - IBoutlets
    @IBOutlet weak var modalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
