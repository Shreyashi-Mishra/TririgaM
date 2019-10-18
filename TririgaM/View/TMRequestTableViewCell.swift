//
//  TMRequestTableViewCell.swift
//  TririgaM
//
//  Created by Shreyashi Mishra on 10/10/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit

protocol TMRequestCellDelegate {
    func textfieldButtonPressed(_ sender: UIButton)
}

class TMRequestTableViewCell: UITableViewCell {
    
    //Mark: IBOutlets
    @IBOutlet weak var requestedTextField: UITextField!
    @IBOutlet weak var buildingTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var roomTextField: UITextField!
    @IBOutlet weak var requestedClassTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    @IBOutlet weak var requestedLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var floorlabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var requestedClasslabel: UILabel!
    
    
    
    @IBOutlet weak var requestedForlabel: UILabel!
    
    @IBOutlet weak var building: UILabel!
    
    @IBOutlet weak var floorLabel: UILabel!
    
    
    @IBOutlet weak var room: UILabel!
    
    
    @IBOutlet weak var requestedClass: UILabel!
    
    var requestCellDelegate: TMRequestCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func requestedForTapped(_ sender: UIButton) {
        
        requestCellDelegate?.textfieldButtonPressed(sender)
        
    }
    
    @IBAction func buildingTapped(_ sender: UIButton) {
        
        requestCellDelegate?.textfieldButtonPressed(sender)
        
    }
    
    
    @IBAction func floorTapped(_ sender: UIButton) {
        
        requestCellDelegate?.textfieldButtonPressed(sender)
        
    }
    
    
    @IBAction func roomTapped(_ sender: UIButton) {
        
        requestCellDelegate?.textfieldButtonPressed(sender)
        
        
    }
    
    
    @IBAction func requestClassTapped(_ sender: UIButton) {
        
        requestCellDelegate?.textfieldButtonPressed(sender)
        
    }
    
    @IBAction func floorCloseTapped(_ sender: UIButton) {
        
        floorTextField.text = ""
        roomTextField.text = ""
    }
    
    
    @IBAction func roomCloseTapped(_ sender: UIButton) {
        
        roomTextField.text = ""
    }
}


extension TMRequestTableViewCell : TMModalDelegate {
    func loadModalData(message: String) {
        requestedLabel.text = message
    }
    
    
}

