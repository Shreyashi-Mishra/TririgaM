//
//  TMWorkTaskSubCell.swift
//  POC
//
//  Created by Ratnadeep Govande on 15/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

class TMWorkTaskSubCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
    @IBOutlet weak var btn_phone: UIButton!
    @IBOutlet weak var btn_message: UIButton!
    @IBOutlet weak var btn_mail: UIButton!
    @IBOutlet weak var btn_map: UIButton!
    @IBOutlet weak var stack_WConstraint: NSLayoutConstraint! // 160*40...
    
    
    // MARK:-
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:-
    func displayInformation(model: TMWorkTaskModel) -> Void {
     
        // display information...
        lbl_title.text = model.title
        lbl_description.text = model.description
        
        // clear all images...
        btn_phone.isHidden = true
        btn_phone.setImage(UIImage.init(named: ""), for: .normal)
        btn_message.isHidden = true
        btn_message.setImage(UIImage.init(named: ""), for: .normal)
        btn_mail.isHidden = true
        btn_mail.setImage(UIImage.init(named: ""), for: .normal)
        btn_map.isHidden = true
        btn_map.setImage(UIImage.init(named: ""), for: .normal)
        
        
        // hidden stack...
        var stack_width = 0
        if model.phone_flag {
            
            stack_width += 40
            btn_phone.isHidden = false
            btn_phone.setImage(UIImage.init(named: "ic_call"), for: .normal)
        }
      
        if model.message_flag {
            
            stack_width += 40
            btn_message.isHidden = false
            btn_message.setImage(UIImage.init(named: "ic_message"), for: .normal)
        }
       
        if model.email_flag {
            
            stack_width += 40
            btn_mail.isHidden = false
            btn_mail.setImage(UIImage.init(named: "ic_mail"), for: .normal)
        }
       
        if model.map_flag {
            
            stack_width += 40
            btn_map.isHidden = false
            btn_map.setImage(UIImage.init(named: "ic_map"), for: .normal)
        }
        stack_WConstraint.constant = CGFloat(stack_width)
    }
    
    @IBAction func phoneButtonClicked(_ sender: UIButton) {
        print("phone button")
    }
    
    @IBAction func messageButtonClicked(_ sender: UIButton) {
        print("message button")
    }
    
    @IBAction func mailButtonClicked(_ sender: UIButton) {
        print("mail button")
    }
    
    @IBAction func mapButtonClicked(_ sender: UIButton) {
        print("map button")
    }
}
